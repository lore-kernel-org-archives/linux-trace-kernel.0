Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F74A346E74;
	Fri,  2 Oct 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937987; cv=none; b=g7PVU/yg1MAhgVS0HDRti5g9fV0pYoCaZD7GtfCZAXWFhMmoESg8p69XXEqkPSLP5iNrJ/1GiHO75Ifsxds74Z32bRUDiWT4fUXi7z7UGmsCcbMnov0xMmijZpcKPNBWV9+rHCqCjQPCNfvfI2nDbNEL06KTdMQSVgjd6OHkfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937987; c=relaxed/simple;
	bh=ZQJ07gpmYbbEG6GvhdN1M+UrkoAN/Od4laf2T+Hwmic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmlpdi6f94cI47w9eieWVNhsy3WkBHV15VBp4klrwzl+LY0ag/EEhSg727YSigz+XuZo088rTZTyyOCRm9fCvT4ZkrQRmCDGczQCiPO6Gk+irRSRCQnjUv27FmS3yAkXcFv31xlzR/RD5cBl9tt6LhCcHEIXVsl1iBpjyFqCXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWC64QWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWC64QWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9A61F000FF;
	Fri,  2 Oct 2026 10:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937985;
	bh=oAv2rOsqA15/L6vfWCnfyySEcVkci68T9Wxx66gwCVQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fWC64QWp2yL8iB3v679sA2BQDWJ77FPzg5FYeIAkbJ78G1KohB3jDilAOXbhWeBn+
	 djcA/RMuM6MxGl2yam5Ts25gfkCZbsWDlg6hgNYjGfALN6E+ghzGcLki+MYgHJr75D
	 BM2q2sCkwEr0pLw5m2YV2gKN0jQ6wEBisdNhPPzg7PwgyJc8ZjvIwEjztxNUf4jHVw
	 own/sWqtt4ILlI+FDI3z8xggpkCQ9kaWJznOgJsBP7AuSlgdkCLw3mCkEcEWgxOmIs
	 RJOvk/B0L/ZPd6JWhGUfnWBrTECXo1ZpUFJaV+mkS+cwfqkjbyio9CDFpF6YOBwwil
	 wIvYNTSNgfBlQ==
Date: Fri, 2 Oct 2026 10:46:03 +0000
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Override the same name trace_instance=
 by latter one
Message-ID: <20261002104603.3cebd743@mhiramat99.roam.internal>
In-Reply-To: <20261002091431.DD73F1F000FF@smtp.kernel.org>
References: <179091984881.537422.15308457677039592540.stgit@devnote2>
	<179091985884.537422.15845141877166136300.stgit@devnote2>
	<20261002091431.DD73F1F000FF@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Oct 2026 09:14:31 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> - [High] tracing: heap out-of-bounds write in
> parse_boot_instance_info due to unescaped tabs
> - [Medium] tracing: duplicate trace array creation via implicit
> backup lookup causes tracefs init failure --
> 
> commit e7d9ac9646a2e104af11665c8c61543d20737c13
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
>     tracing: Override the same name trace_instance= by latter one
>     
>     Override the same name boot instance by the latter parameter.
>     This allows user to override the trace instance in bootconfig by
> the cmdline from bootloader.
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index e4a490d3d08c8..4590d38969450 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -308,6 +309,7 @@ static int __init boot_instance(char *str)
> >  
> >  	ret = snprintf(slot, left, "%s\t", str);
> >  	boot_instance_index += ret;
> > +	nr_boot_instances++;
> >  
> >  	return 1;
> >  }  
> 
> [ ... ]
> 
> > +__init static void parse_boot_instance_info(struct boot_instance
> > *boot_instances) {  
> 
> [ ... ]
> 
> > +	while ((events = strsep(&str, "\t"))) {
> > +		if (!*events)
> > +			continue;  
> 
> [ ... ]
> 
> > +		for (i = 0; i < idx; i++) {
> > +			/* Override by the last defined instance */
> > +			if (!strcmp(name, boot_instances[i].name))
> > +				break;
> >  		}
> >  
> > +		boot_instances[i].name = name;
> > +		boot_instances[i].flag_delim = flag_delim;
> > +		boot_instances[i].addr_delim = addr_delim;
> > +		boot_instances[i].backup = backup;
> > +		boot_instances[i].events = events;  
> 
> [Severity: High]
> If a user provides a quoted parameter containing a literal tab (for
> example, trace_instance="foo\tbar"), won't strsep(&str, "\t") split
> it into more tokens than what was originally counted in
> nr_boot_instances?
> 
> This loop appears to write beyond the bounds of the boot_instances
> array when there are embedded tabs, which could lead to memory
> corruption and a kernel panic during early boot.

Ah, OK. Such usage is not recommended but it can happen and
causes array index overrun.

> 
> > +		if (i == idx)
> > +			idx++;
> > +	}
> > +
> > +	nr_boot_instances = idx;
> > +}
> > +
> > +__init static void enable_instances(void)
> > +{
> > +	struct boot_instance *boot_instances __free(kfree) = NULL;
> > +	struct boot_instance *bi;
> > +	struct trace_array *tr;
> > +	bool memmap_area = false;
> > +	char *tok;
> > +
> > +	if (!boot_instance_index)
> > +		return;
> > +
> > +	/* Parse the instance name to check the overlap */
> > +	boot_instances = kmalloc_array(nr_boot_instances,
> > +				       sizeof(*boot_instances),
> > GFP_KERNEL);
> > +	if (!boot_instances)
> > +		return;
> > +
> > +	parse_boot_instance_info(boot_instances);
> > +
> > +	for (int i = 0; i < nr_boot_instances; i++) {
> > +		char *rname __free(kfree) = NULL;  
> 
> [ ... ]
> 
> > -		if (trace_array_find(name)) {
> > -			pr_warn("Tracing: Instance %s already
> > exists\n", name);
> > -			continue;
> > -		}
> > -
> > -		if (backup) {
> > -			if (backup_instance_area(backup, &addr,
> > &size) < 0)
> > +		if (bi->backup) {
> > +			if (backup_instance_area(bi->backup,
> > &addr, &size) < 0) continue;
> >  		}  
> 
> [ ... ]
> 
> > -		tr = trace_array_create_systems(name, NULL, addr,
> > size);
> > +		tr = trace_array_create_systems(bi->name, NULL,
> > addr, size);  
> 
> [Severity: Medium]
> With the trace_array_find() check removed, does this unconditionally
> create a new trace array, even if one implicitly exists?

parse_boot_instance_info() already checks the overlaps.

> 
> If a user specifies a trace_instance with a backup pointing to
> another instance defined later (e.g., trace_instance=foo=bar
> trace_instance=bar), backup_instance_area() will implicitly create
> "bar" via trace_array_get_by_name().

Ah, that's a good point! we should check it in
parse_boot_instance_info().

> 
> When the loop processes "bar" explicitly later on, it seems this code
> will call trace_array_create_systems("bar", ...) a second time,
> duplicating the trace array in ftrace_trace_arrays. This duplicate
> could cause tracefs_create_dir() to fail and abort initialization of
> subsequent trace instances.
> 

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
