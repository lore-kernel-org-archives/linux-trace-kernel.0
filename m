Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEB2374A11
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568011; cv=none; b=VA/03xc7z+YFAtDhCNVxSQJ54ex+eKU/FzMO9oo9Cipd0Y4YuIdUR/lBirGNnxviXpD2JoF/phxUF6v/xNbmaqeLvf+TZTfa9ZCEOo4Dz0peC5nnIP6fjw4I9bh9PzFOM5G5IqWDtImtdNEHZ5l09/R8uNAulkRPgui8fIjGdVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568011; c=relaxed/simple;
	bh=uV+/OeTa8jtxaNO6YgOtaGXKVxEFn9vxrH9rLc95kag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bEzZgVWeueeJti7yyJ8KjvD8TaKX8YQsuvvJTv24wnCV8ZogXO1eOJBXq6i6QuLPpvTxvNlM62nu7EhTaiohyA9Ftb4Cs6OsupcbrDPpethjy4GjoSPwlmyBUvzFU+2T0i35Dtvg9aw0Wuo2yGoHCO7sQ/eWMnxemrryWbVNBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISzv9EFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISzv9EFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7CF1F000E9;
	Mon, 24 Aug 2026 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787568009;
	bh=DQycIxXvFoBfG3BF5hoJAKalpBOX07Jx1xeWWom84UA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ISzv9EFweTRGVQcQ5OSL74t0059P95QO1fLeSb4OIJZwCtEwKiAUAikrHiTmHsULN
	 C0dROWe+L6Z2o6EBNyklhFda+rBBJZwaC4ARcuIpBLVy5rWJiEuwKJjrl4Gcur+z7t
	 QGXyXugjAeHn7SB5Kd8FMhzqYM9PA/1ynhlMxh+QwNdCRv3AIbTzsKlIk2E783PKyZ
	 +rKW2smqtzGRymgzcHtZbiEuW4WxfS/Zkd0T+4ZTD6cJRcqvsd+fQPnp4ezCIQCMu+
	 9X/ZmNcHllYIyUJIowI0qq+80sW4d0JbB/eIHENYBVJV9TQkmVBa5IUhrsmiBz1x1A
	 iFqmLZB+UvISQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing: Fix use-after-free on field name/type of
 dynamic probe events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260824102029.4132962-1-bsdhenrymartin@gmail.com>
References: <20260824102029.4132962-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:40:09 +0000
Message-Id: <20260824104009.9E7CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double free of `field->type` string during module unload for trace=
 events utilizing enums or sizeofs.
- [Medium] Original `field->type` string allocated via `kstrdup_const` is p=
ermanently leaked when updated.
--

--- Patch [1]: [PATCH v2] tracing: Fix use-after-free on field name/type of=
 dynamic probe events ---
commit b954fc1bd8487842009bed83382854061ec8a285
Author: Henry Martin <bsdhenrymartin@gmail.com>

tracing: Fix use-after-free on field name/type of dynamic probe events
   =20
Fields of a probe-based dynamic event (kprobe, uprobe and eprobe
events) are created from the argument name and type strings of the
trace_probe that first registers the event, as plain pointer
references without copying.

[ ... ]

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0356cae0cf74e..13d7675bc5132 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -122,8 +122,18 @@ static int __trace_define_field(struct list_head *he=
ad, const char *type,
>  	if (!field)
>  		return -ENOMEM;
> =20
> -	field->name =3D name;
> -	field->type =3D type;
> +	field->name =3D kstrdup_const(name, GFP_TRACE);
> +	if (!field->name) {
> +		kmem_cache_free(field_cachep, field);
> +		return -ENOMEM;
> +	}
> +
> +	field->type =3D kstrdup_const(type, GFP_TRACE);

[Severity: Medium]
Will this original field->type string be leaked when the field uses enums
or sizeofs?

When a module defining trace events is loaded, this kstrdup_const() allocat=
es
the string for field->type, because module rodata falls outside the core
kernel rodata range.

Later in the initialization sequence, trace_event_eval_update() invokes
update_event_fields(), which replaces field->type without freeing the
original allocation:

kernel/trace/trace_events.c:update_event_fields() {
    ...
		str =3D kstrdup(field->type, GFP_KERNEL);
        ...
		if (call->module)
			add_str_to_module(call->module, str);

		field->type =3D str;
    ...
}

Should the original dynamically allocated pointer be freed before being
overwritten here?

> +	if (!field->type) {
> +		kfree_const(field->name);
> +		kmem_cache_free(field_cachep, field);
> +		return -ENOMEM;
> +	}
> =20
>  	if (filter_type =3D=3D FILTER_OTHER)
>  		field->filter_type =3D filter_assign_type(type);

[ ... ]

> @@ -205,6 +215,8 @@ static void trace_destroy_fields(struct trace_event_c=
all *call)
>  	head =3D trace_get_fields(call);
>  	list_for_each_entry_safe(field, next, head, link) {
>  		list_del(&field->link);
> +		kfree_const(field->name);
> +		kfree_const(field->type);

[Severity: High]
Could this introduce a double free during module unload for events using en=
ums
or sizeofs?

During module load, update_event_fields() allocates a new string via kstrdu=
p()
and assigns it to field->type, and also adds it to the module_strings list.

During module unload, trace_module_remove_events() iterates through the
module's events and calls __trace_remove_event_call(), which calls
trace_destroy_fields(). This newly added kfree_const(field->type) will free
the string allocated by update_event_fields().

Immediately after doing that, trace_module_remove_events() iterates the
module_strings list:

kernel/trace/trace_events.c:trace_module_remove_events() {
    ...
	/* Check for any strings allocade for this module */
	list_for_each_entry_safe(modstr, m, &module_strings, next) {
		if (modstr->module !=3D mod)
			continue;
		list_del(&modstr->next);
		kfree(modstr->str);
		kfree(modstr);
	}
    ...
}

Will this cause kfree(modstr->str) to free the exact same string pointer a
second time?

>  		kmem_cache_free(field_cachep, field);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824102029.4132=
962-1-bsdhenrymartin@gmail.com?part=3D1
