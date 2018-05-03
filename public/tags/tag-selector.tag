<tag-selector>
    <div class="back"></div>
    <form ref="form" class="card" onreset={ cancel } onsubmit={ submit }>
        <div class="card-section grid-y">
            <div class="contents cell medium-auto" if={ !loading }>
                <label each={ item in items } class={ opts.fullWidth ? 'full-width' : '' }>
                    <input type="checkbox" checked={ item.selected } onchange={ parent.elementChecked }>
                    <div class="content"><div data-is={ opts.component } item={ item }></div></div>
                </label>
            </div>
            <div class="toolbar cell medium-shrink" if={ !loading }>
                <button class="button" if={ opts.hasAdd } onclick={ addClick }><i class="fa fa-plus"></i></button>
                <button class="button float-right" type="submit"><i class="fa fa-check"></i></button>
                <button class="button float-right" type="reset"><i class="fa fa-remove"></i></button>
            </div>
            <spinner if={ loading }></spinner>
        </div>
    </form>

    <style>
        :scope {
            width: 0;
            height: 0;
            margin: 0;
        }

        form {
            position: fixed;
            display: block;
            top: 1em;
            bottom: 1em;
            left: 50%;
            transform: translateX(-50%);
            max-width: 600px;
            width: 100%;
            z-index: 20;
        }

        .back {
            position: fixed;
            display: block;
            background: rgba( 0, 0, 0, 0.5 );
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 10;
        }

        .card-section {
            position: relative;
            padding: 0;
        }

        .contents {
            overflow: auto;
            text-align: center;
            padding: 0.5em 1em 0.5em;
        }

        label {
            position: relative;
            display: inline-block;
            margin: 1em;
        }

        label.full-width {
            display: block;
            margin: 1em 0;
            width: 100%;
        }

        .content {
            cursor: pointer;
            border: 4px solid white;
        }

        input[type="checkbox"] {
            display: none;
        }

        input[type="checkbox"]:checked + .content {
            border: 4px solid #23a3ba;
        }

        input[type="checkbox"]:checked + .content::after {
            content: "\002715";
            position: absolute;
            display: block;
            width: 1rem;
            height: 1rem;
            bottom: -0.5rem;
            right: -0.5rem;
            background: #23a3ba;
            color: white;
            line-height: 1;
        }

        .toolbar {
            border-top: 1px solid #e6e6e6;
            font-size: 0;
        }

        .toolbar > *,
        .toolbar .button {
            display: inline-block;
            margin: 0;
        }

        spinner {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translateX(-50%); translateY(-50%);
        }
    </style>

    <script>
        this.items = [];
        this.loading = false;

        let that = this;

        setItems( items ) {
            that.items = items;
            that.update();
        }

        this.on('mount', function() {
            opts.itemGetInitier( that );
        });

        function getItems() {
            let items = [];
            for( let i = 0; i < that.items.length; i++ ) {
                if( that.items[ i ].selected ) {
                    items.push( that.items[ i ] );
                }
            }
            return items;
        }

        elementChecked(e) {
            e.item.item.selected = e.target.checked;
        }

        addClick( e ) {
            e.preventDefault();
            e.stopImmediatePropagation();
            opts.add( that );
        }

        submit(e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            let items = getItems();
            this.unmount();
            if( opts.onSelected ) {
                opts.onSelected( items, that );
            }
        }

        cancel(e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            this.unmount();
            if( opts.onCancelled ) {
                opts.onCancelled( that );
            }
        }

        loading() {
            this.loading = true;
        }

        notLoading() {
            this.loading = false;
        }
    </script>
</tag-selector>