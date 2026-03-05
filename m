Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9827E05E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719381; cv=none; b=aYVn1+6obAlW/Mg+xSmPrHTtHtC82XtAaxnmnLaVPdT3LdldwzeGcZCPuqNjP93vI9BifXFpOfdFBtUWsB8i6lX2CW/q5J9h+67rbcjR/XWPsygotVeiD1nZrWQcxVZG/++cZErgZJ+5kHlBbUab0ahAGYJBXXNS80pZHTX9rDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719381; c=relaxed/simple;
	bh=5kkbubYy4FnU0F2wQ5CgXGyB2dALRdLIq2BTPUeGbMU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBIGnEaLd9RFdjYm7dVBdZk1J3WUXFeSw2hbSQkVxEY5kVwAPWNuI7nBZdEUQAFYEaaaBbjPBpGXB2/AwjGLr5aUvSHughiiSLabEq5ETnfBewtAVPDOrnaTc5soMGseacvG1YlJicRMwt99qQo1CdGiF1jyoSB3tHaN6662uxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6qfAn0c; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6qfAn0c"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483770e0b25so68795345e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 06:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719379; x=1773324179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gc32faIZSqifYGedhNQqSI6XI0cDDSqa8ioUwK5io4=;
        b=S6qfAn0ch6vt0YJyKh542nbikJl4u+37ga62FIg8Pq8E8AWo18DBATIppf77FgnS6N
         qM50rvrmlM+uxTR66K3YDfEfK1JZPmyydx/mIHlXZvGNrO3mYO9KrNnJoYRRNiofCOa4
         1s5ppHUOPotsfnJGATbKJw6cIuelVoHFArD5erwtqrOt81qJ1X0szY6GzVzpePOFZqgE
         jxD3J6fD0bM/lyoQMsLhFgWCB7TlZy/sRRUYNeaUKCR/Ri1oN+IOHKhNyyBBfxYYbW8K
         WuDTMAX8gVRTzIwKBVtJv1RBMQTWwHDXIb/Rrxe1fmsbTfPz9uODAeVRioHwk64g5aaS
         0UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719379; x=1773324179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gc32faIZSqifYGedhNQqSI6XI0cDDSqa8ioUwK5io4=;
        b=OoMV056k6H9l177ha/OnpmhX+T74hubZ/oHml10ODoIpRXJYnoe0uVVildyVryQPM1
         cc7u8Ggbg+dIbQOzJuJaEZg16P7rygdixYLPztNPza5SxNngDlVybe9VYWN+jujO31uu
         uFlZjIvIJrulDtItheBUJyeEQ9uFJURQ5qkSMtSB8Io37vBA/xWmRWXIKF8hx+wehuZE
         KhcYo/WlhC3sdvVqrmeSHBNj6dyDz2/E4a3bVa4GME6voAC/BWyYUf9rAFb7ofrprZ6r
         5adqiinVtTMubFzMr5ZmIF31My31KSK/hywb7wuBDBJZ7FuJwdi434vSwDDsCktpgQ+Y
         ZBOw==
X-Forwarded-Encrypted: i=1; AJvYcCVQl4f1yb/UYv4npi7XO2sOpMzvwcC1sqZHwcXyLbBKVfBeaxXY6rojw4Q/5K+vimOIZrKlh8gFczSsg2EMo+BGhMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFOz7GdvHVwX5E99CWUaYPmOED4aH+gyRsjqxJgZNa9WsE/mO
	eO5vAR1CrIUehvvv1Gq/L+jmf++yDgL+gM3LvcoWRxPRK4Q/jhRvNNWd
X-Gm-Gg: ATEYQzwaLjRM2OaIdj57Jzj1YcEWjgbIdIXdfImKIhCgGMDFsi0ZS1tONWawFQaEain
	3LrbOrEaFk60BX+7+RKc6926xg0ELUVOlP+EaPD9Buwn/jf4P08SizErk0RJ74+Eg6LcbIYb0nY
	IGtCa/+QszqY10SriJ+fxyfzU0+nHNbjSAGnPNPk4zgeRWKLYni1Vu2AxLWN16MTm0sANL0Lnqg
	LexyXx50NdRSWg6g+OdOare5sRKgz9xLjfi1+OW+f0+iWSnGaLw3zbHugi+d2osmpGQ2OyLLGr4
	zW7Bnvh7xBLpbqRm1EXR+8wlppi19JsNVHTMvtF9A9qg0u6Rdu6emFo2OueuhgywT6LuUOBRsHh
	RHXfuiZbzeX9qhZDe+mSRBe6EZ+7VKgW6HqEMfipWMnz/Q60co26EiR/hSjLLG8Qi3J7Owd5K
X-Received: by 2002:a05:600c:6992:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-4851984fd72mr103483905e9.10.1772719378184;
        Thu, 05 Mar 2026 06:02:58 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fade9fdsm79672885e9.4.2026.03.05.06.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:57 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:56 +0100
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCHv2 bpf-next 15/23] libbpf: Add support to create tracing
 multi link
Message-ID: <aamNEBkUuqKr2XQR@krava>
References: <20260304222141.497203-1-jolsa@kernel.org>
 <20260304222141.497203-16-jolsa@kernel.org>
 <0f3ec422-4b98-4311-96de-ccfc86bb22ad@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3ec422-4b98-4311-96de-ccfc86bb22ad@linux.dev>

On Thu, Mar 05, 2026 at 02:59:48PM +0800, Leon Hwang wrote:

SNIP

> > +static int tracing_multi_mod_fd(struct bpf_program *prog, int *btf_obj_fd)
> > +{
> > +	const char *attach_name, *sep, *mod_name = NULL;
> > +	int i, err, mod_len = 0;
> > +
> > +	*btf_obj_fd = 0;
> > +	attach_name = strchr(prog->sec_name, '/');
> > +
> > +	/* Program with no details in spec, using kernel btf. */
> > +	if (!attach_name)
> > +		return 0;
> > +
> > +	attach_name++;
> > +	sep = strchr(attach_name, ':');
> > +	if (sep) {
> > +		mod_name = attach_name;
> > +		mod_len = sep - mod_name;
> > +	}
> > +
> > +	/* Program with no module section, using kernel btf. */
> > +	if (!mod_name)
> > +		return 0;
> > +
> > +	err = load_module_btfs(prog->obj);
> > +	if (err)
> > +		return err;
> > +
> > +	for (i = 0; i < prog->obj->btf_module_cnt; i++) {
> > +		const struct module_btf *mod = &prog->obj->btf_modules[i];
> > +
> > +		if (mod_name && strncmp(mod->name, mod_name, mod_len) == 0) {
> 
> strncmp() is not enough to exactly compare two module names, as
> strncmp() only compares the first 'mod_len' bytes.
> 
> So, mod_name "foo" could match mod "foobar", since 'obj->btf_modules'
> are not sorted by name after loading from kernel.
> 
> To find the exact module via module name, "strncmp() == 0 &&
> mod->name[mod_len] == '\0'" would be better.

yes, good catch, will fix

SNIP

> > +static int collect_func_ids_by_glob(struct bpf_object *obj, const char *pattern, __u32 **ids)
> > +{
> > +	const char *mod_name = NULL, *sep;
> > +	int i, err, mod_len = 0;
> > +	struct btf *btf = NULL;
> > +
> > +	err = bpf_object__load_vmlinux_btf(obj, true);
> > +	if (err)
> > +		return err;
> > +
> > +	/* In case we have module specified, we will find its btf and use that. */
> > +	sep = strchr(pattern, ':');
> > +	if (sep) {
> > +		mod_name = pattern;
> > +		mod_len = sep - pattern;
> > +		pattern = sep + 1;
> > +
> > +		err = load_module_btfs(obj);
> > +		if (err)
> > +			goto cleanup;
> > +
> > +		for (i = 0; i < obj->btf_module_cnt; i++) {
> > +			const struct module_btf *mod = &obj->btf_modules[i];
> > +
> > +			if (!strncmp(mod->name, mod_name, mod_len)) {
> 
> Same concern here.
> 
> Would it be better to factor out a helper to find module via name?

we have similar issue in find_kernel_btf_id, but we get away with
that with just continuing to loop modules if the lookup fails

I agree some helper would be good hear, will try to add it

thanks,
jirka
