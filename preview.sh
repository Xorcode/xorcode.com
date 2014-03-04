#!/bin/bash
rm -Rf source/_layouts source/_assets && rake update_source[xorcode] && rm -Rf source.old && rm -Rf public && rake preview
