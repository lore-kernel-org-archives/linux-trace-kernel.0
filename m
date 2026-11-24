Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529345;
	b=zj+9qwyYOvPsHNzejK6zwIwfGqHFwR8Ek5IslIeH6ZXJ7ArysVR+PcJdW+kJHEVVdjcT
	 g0j0f4z7TtMEnm1SwD8OkXjahJ8Yw3HYDvvJxh3zm4vLWCKHn2JHR6PA5RUlL0JWUP5a/
	 rvNcSVc0pRkWvocMK0L1wbguJqoRML8reaHCEOEh2JtTB7je9a8BxCrK4koEYlv1U79X7
	 SD1gN+pwxvciNB5yGd4UtvMEv/ugTDWh2AgkWjcs5gmw3ErEaODZplAaatICSwBIymg4Q
	 EolBQEyJvD1RsGfN2pmIwckHuaXJ8XEsgZyyG5oAwvdlCnsrTt4hu48V7gFucGuxpTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529345;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=aVPFdn6DuZS/F9pbwCoFPUfuEo0LzApE6aMqeQkxu3Y=;
	b=XngaYXwzGgX4pVGGS4+qt5uLOzekIqZunfgigg5tkxn4omyY3fy6OJdc9fbYRBlIGMS5
	 DlVDq1r9dTZIkNsQ2aD59LkXee1Ywt9xXCWI9I46wrEG0mW7YF8DiMuFqlHzXcqZYSXst
	 mFkbP+J0K1PHvbTukwBGIw+npAjRPBfa+Jcr99z4j6f1wZWzL0NaWOhtdXP4lDPMGWGKr
	 kJarWr5R1xjtoS7D9+pgADHFvndkn1ernaP8O3/X7vJ14DSfjj1g12WurQQwyQ+oY0OTM
	 5K/qXsArOnO/hFnUv+kuBXvwgPIF6ljTjL+3uPNRI6/ghzJh+g/+3AOLzNcQ2xfPr6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=kwOn3mgB;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ABF606A33B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 14:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08ABF606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=kwOn3mgB
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 501C6C0BB3;
	Tue, 24 Nov 2026 14:08:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id BE26830;
	Tue, 24 Nov 2026 14:08:55 +0000 (UTC)
Date: Tue, 24 Nov 2026 09:08:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] tracing/probes: Zero out faulted dereferenced fields
Message-ID: <20261124090849.7fe8d45f@gandalf.local.home>
In-Reply-To: <sashiko-outbox-230424@kernel.org>
References: <20261123213246.00440bfc@gandalf.local.home>
	<sashiko-outbox-230424@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BE26830
X-Stat-Signature: ot4naimnyoaang9d1njejwj7xax91k9x
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/72N1PpDHfrZwNSQrXUcGkx77OfDDA/Lo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=aVPFdn6DuZS/F9pbwCoFPUfuEo0LzApE6aMqeQkxu3Y=; b=kwOn3mgBxMbn+lgJhMS1+fqXYF0r4RdB754suOpFH3gK/FdnrgbTGnyYvAsbC7NLrXoKxlP1RNVnUfDqnukmlQWWOfDxgp2FQQqRnWI23yzkN/z5G+NzVFKNrOhHN68wBKOHGKF+WVL7vdOgzodR39yITgHAR6ulQOMVgOas5tk=
X-HE-Tag: 1795529335-314881
X-HE-Meta: U2FsdGVkX1/a+rzs03GS0zd11Xm7B+10FL4s8z9+H4q1/Wh7HYXat7UtVrx7DKUZgunvtcG+LTlrVFftoB2Va9fpoJJk3GYpMCKANYP6WEosd28+3cfDEncH/i7jMIXyre3+NZ3j0oWMvJGpQ3uDMc3eJORLCZJ6WAEnpHWL8mpPwm1P/j0ALlZ5zZqlr+XW5uATdkmynYSKbcAYhj4NG6sHjLe44ZY5SlebQZ7AZNWT4vTpEgSAXdTI6S2go2SrjvCkPGWUesH0gcBcdWQR0l0BqE5UbCKhDcWbDkD3Z9Q43VsuP9j4WtZvTevzQPOHSILXckE3i4+0oj9wJ3qEhGcKnyRzWjY8

On Tue, 24 Nov 2026 02:51:12 +0000
sashiko-bot@kernel.org wrote:

> > @@ -193,27 +256,30 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
> >  		}
> >  	}
> >  
> > +	/* When val is NULL, so should the val + offset */
> > +	offset = val ? code->offset : 0;
> > +
> >  	switch (code->op) {
> >  	case FETCH_OP_ST_RAW:
> >  		fetch_store_raw(val, code, dest);
> >  		break;
> >  	case FETCH_OP_ST_MEM:
> > -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> > +		do_probe_mem_read(dest, (void *)val + offset, code->size);
> >  		break;
> >  	case FETCH_OP_ST_UMEM:
> > -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> > +		do_probe_mem_read_user(dest, (void *)val + offset, code->size);
> >  		break;  
> 
> [Severity: Medium]
> Should do_probe_mem_read() and do_probe_mem_read_user() check for a NULL
> src before calling probe_mem_read() and probe_mem_read_user()?

No, but I guess I should add that as we probably shouldn't be dereferencing
zero when something fails.

-- Steve
