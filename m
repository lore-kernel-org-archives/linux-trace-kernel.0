Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56446476CFE
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Oct 2026 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932473; cv=none; b=qv8tYSKo+U3iyIXg5stlo0iEw91lVQVK8/lwiBRjI8N8VAEX6h6NhBWgSnMePhoibPZl6nzN579aMaJPJmD354M+4uu1RY9rxefUrzO6hJm/ELW5ts1vbUQjk06Ve7bwOGNFi9kaduhnNfb9LUp8GZZuUBjQxgIibxwYhIkO6pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932473; c=relaxed/simple;
	bh=dyrDYpNWL1bTPF7x3xI7O49jv3XXqEIKXknFHvksTJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uUfKZH3A5xAPwg9Q42nWnWybbIRBXvpuSyyi+uX9Sk9tP1EFH1VvDPzJOjipjUT8m6IIUCE+mfvAnUARzcXp7U6w0t5x1MTD/YvhRSpii9dMxu0sUxngKOv2cEa6icKYfgj8fR/GVmrnlan1PwBaz8G6OsSQckgk9GVpkoGlWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pys9E4Os; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pys9E4Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD73F1F000FF;
	Fri,  2 Oct 2026 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932472;
	bh=7YRDtfmZbAfDFlT/T6Q/vDPRBQWPLAjbPQ95ldA6KDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pys9E4OsgppR1afHVcszFBf1b9M6EQpYxsbGwSmwxVDez7qxy1fn1m3EsP4vpA2eq
	 vM+kpgDPp1Bu4gE1wQxtq6D5xJfa5p72VurHFa4HXrOom8W6Tk3FUE9oJokuW7+Qf9
	 tkZrwIxP3fr6BnfG2JJl8AN5MtjPtFKUb7a2206GDDfQ9PNBdLI/g5Q1PKbWGRFdX2
	 NnQpQRg4NhQcWM6ooSLcX+wtIcsbDOIxnsZgc1YoDtWgJ5N2gM6nOIB0ctFmiJzgny
	 fxyj8ZsxX7lgl4b21kaDQ8MiIETCoLSL39q4DphLIQjhrat7CG0xnWrGl/q2aiwqxP
	 14mN3yXcMyiag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Override the same name trace_instance=
 by latter one
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179091985884.537422.15845141877166136300.stgit@devnote2>
References: <179091984881.537422.15308457677039592540.stgit@devnote2>
 <179091985884.537422.15845141877166136300.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:31 +0000
Message-Id: <20261002091431.DD73F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] tracing: heap out-of-bounds write in parse_boot_instance_info due =
to unescaped tabs
- [Medium] tracing: duplicate trace array creation via implicit backup look=
up causes tracefs init failure
--

commit e7d9ac9646a2e104af11665c8c61543d20737c13
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

    tracing: Override the same name trace_instance=3D by latter one
   =20
    Override the same name boot instance by the latter parameter.
    This allows user to override the trace instance in bootconfig by the
    cmdline from bootloader.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e4a490d3d08c8..4590d38969450 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -308,6 +309,7 @@ static int __init boot_instance(char *str)
> =20
>  	ret =3D snprintf(slot, left, "%s\t", str);
>  	boot_instance_index +=3D ret;
> +	nr_boot_instances++;
> =20
>  	return 1;
>  }

[ ... ]

> +__init static void parse_boot_instance_info(struct boot_instance *boot_i=
nstances)
>  {

[ ... ]

> +	while ((events =3D strsep(&str, "\t"))) {
> +		if (!*events)
> +			continue;

[ ... ]

> +		for (i =3D 0; i < idx; i++) {
> +			/* Override by the last defined instance */
> +			if (!strcmp(name, boot_instances[i].name))
> +				break;
>  		}
> =20
> +		boot_instances[i].name =3D name;
> +		boot_instances[i].flag_delim =3D flag_delim;
> +		boot_instances[i].addr_delim =3D addr_delim;
> +		boot_instances[i].backup =3D backup;
> +		boot_instances[i].events =3D events;

[Severity: High]
If a user provides a quoted parameter containing a literal tab (for example,
trace_instance=3D"foo\tbar"), won't strsep(&str, "\t") split it into more t=
okens
than what was originally counted in nr_boot_instances?

This loop appears to write beyond the bounds of the boot_instances array wh=
en
there are embedded tabs, which could lead to memory corruption and a kernel
panic during early boot.

> +		if (i =3D=3D idx)
> +			idx++;
> +	}
> +
> +	nr_boot_instances =3D idx;
> +}
> +
> +__init static void enable_instances(void)
> +{
> +	struct boot_instance *boot_instances __free(kfree) =3D NULL;
> +	struct boot_instance *bi;
> +	struct trace_array *tr;
> +	bool memmap_area =3D false;
> +	char *tok;
> +
> +	if (!boot_instance_index)
> +		return;
> +
> +	/* Parse the instance name to check the overlap */
> +	boot_instances =3D kmalloc_array(nr_boot_instances,
> +				       sizeof(*boot_instances), GFP_KERNEL);
> +	if (!boot_instances)
> +		return;
> +
> +	parse_boot_instance_info(boot_instances);
> +
> +	for (int i =3D 0; i < nr_boot_instances; i++) {
> +		char *rname __free(kfree) =3D NULL;

[ ... ]

> -		if (trace_array_find(name)) {
> -			pr_warn("Tracing: Instance %s already exists\n", name);
> -			continue;
> -		}
> -
> -		if (backup) {
> -			if (backup_instance_area(backup, &addr, &size) < 0)
> +		if (bi->backup) {
> +			if (backup_instance_area(bi->backup, &addr, &size) < 0)
>  				continue;
>  		}

[ ... ]

> -		tr =3D trace_array_create_systems(name, NULL, addr, size);
> +		tr =3D trace_array_create_systems(bi->name, NULL, addr, size);

[Severity: Medium]
With the trace_array_find() check removed, does this unconditionally create=
 a
new trace array, even if one implicitly exists?

If a user specifies a trace_instance with a backup pointing to another inst=
ance
defined later (e.g., trace_instance=3Dfoo=3Dbar trace_instance=3Dbar),
backup_instance_area() will implicitly create "bar" via
trace_array_get_by_name().

When the loop processes "bar" explicitly later on, it seems this code will =
call
trace_array_create_systems("bar", ...) a second time, duplicating the trace
array in ftrace_trace_arrays. This duplicate could cause tracefs_create_dir=
()
to fail and abort initialization of subsequent trace instances.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179091984881.537422=
.15308457677039592540.stgit@devnote2?part=3D1
