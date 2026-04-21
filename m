Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1023A0E95
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761685; cv=none; b=lSm0WahZV4eN4BvO23Um1vLcKe1OPIlLF36z4w0c+lAFFLoaxrO9LTc/lJwNzeAez7hSEzRg9cGqYRcCbKwGB5uX4Nby4EvyjZaMuu/g/Ac33UxpBDv1DuXc9JksN/VUuciOj1pjmNUW7aPMuJhSiSEUpPxVfhJY5itBY2pXcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761685; c=relaxed/simple;
	bh=3Rm0j0jpOm7x8JB70ao9c9n0Rm6yAuqSFxiPxK37h98=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL6zcT47ecMwdaMy3uztm97d+OU8XTNnjYuUskHf30nUhUx868/OD7LJicCrWti28CRjt8PgdhpejYy2cTNLgvVBInj0UxVHEO/eybfaxbxJVi7ZOcaICKRoM4lu6L2BcpdWSTjITUEDmQ1Jd/wu0obaFVjsFtTAnp3idKWLBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzIBhvCz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzIBhvCz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2313888f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761680; x=1777366480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEBDw/CHdgROimN+5rHeTkzLPXnxJmB91Vu74p3MB2g=;
        b=LzIBhvCzNXEH6KjJgVHGWXX2Te9CLdOCeNkEdJ7U/93fLVAa6beKynxzE9ts5/kY31
         zhKkauGux7nAe3RmZfwfl40J3aLbkzmofznSzO7y8SOiZFAIt9w3CtUHtKDtt8Fsxyn8
         E4Yvsx0wh+sXAcGIUEOpwh5gZFTdB5tGvm2or1cV7ogxe1QdRiB2BkHl+vxpFJkAa3dk
         6W6XiEgugPoqvq3ZZP6vDwsJSAth1ygjfATTBcow2BTFnY0HWfaRHfrV2bPnBA81pHvf
         a6V/4ZswGpHGJvVDYF7GqtWXL5srN4hTLUgitjUN167V5VNeVIktMElAWQzO1B9tYKVq
         E1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761680; x=1777366480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEBDw/CHdgROimN+5rHeTkzLPXnxJmB91Vu74p3MB2g=;
        b=e4ZVt83SuW+dxlFNFKLOf782SVW/mERjiHM9wkhNN5bY5epSJfUiFovfFATAYFbQ2k
         FoigkbR9zoTyJ/8ouAuG08kCXS8mjYpBrSFP/+6ijdpO5SRBkMCCmsbQsVNnjhkJsj2W
         Db8Na4i1Adlq8HQCNHJalVNg1FcVbVd3MwZ2BOdN63BOswGn2PAVuuuGW+qbUmfTvixc
         NzwI9iklUD3RWe+aTzXNN+W9yizd7R9kav6VC1/mvHb7POuot6Td5Wf6+yVYrOfoSEkc
         AWdccEkxSiCM6312ZEaMKGMOMd0YaLoSTP4Ulj/OhzDzN7iv+9pQEcYkyTGBfVeIORf0
         ehWw==
X-Forwarded-Encrypted: i=1; AFNElJ85kRWc1ehOv54xC2/pZwTxwYMg25EYyvuSuPMxrYSHjcjUGId6xYsaE89ug292G8yBnfHu/N6A95eTJkqgpJkUQCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkmImT6W4hXNUZEeTEC/pmTZQfLhmMzIgz7A/tSVkpgvgidjqa
	vVareOsxnDO/RUZIDWzznKr2ZHngwnitaykepAVqmbw3arzg+HDrAmwc
X-Gm-Gg: AeBDievzPj1axBqqwMTdxigYAXCTttnrZOkqzSPnJTGn9UABuS46nRdUVpZRs7NGgfT
	3viZNRIThLkX+YjFpgpqnUYfR/ISfoVcsmbWhbZD2aTNf53yKVhjr9FmzkEwN7d8VeR157U/zrG
	iu1ZnSTobwgwdgOJKmnnTp91ClDxP8UNEnGz7sD+SXtnOjtEPHkxtz9WiaNAhkoSEtVbfYZpZoX
	kOc7FIj9BrhF7r8n5DyjQZq0eBdl1ys5Qfc0dCNeNCpuetjIUTGME0LDT285IFnN9hpAIsJhGZW
	v1D2vFm8pNeZHV7Y1oK4Slf8AkDnYsieip4r1UR03GZjOqBEJlfq9JFos4qDQmtXLwYpSoIG7X5
	qnr7n/Za47khUE1BL24Nh3g18yq6D52Cu20QuFMC5S2gltKY/NWB1tIGxGmyiCqyuZ+6xqC+CIN
	qNL/xQkgE=
X-Received: by 2002:a5d:5889:0:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-43fe3e0c7ebmr27454724f8f.41.1776761680216;
        Tue, 21 Apr 2026 01:54:40 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm35813045f8f.16.2026.04.21.01.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:54:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:54:37 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 21/28] selftests/bpf: Add tracing multi
 skel/pattern/ids attach tests
Message-ID: <aec7Ta9m8Q86N4l2@krava>
References: <20260417192502.194548-22-jolsa@kernel.org>
 <1ab81cf709ce7d536a898695ffad30c15c8a6a7bf48dcb7271239952dd270315@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ab81cf709ce7d536a898695ffad30c15c8a6a7bf48dcb7271239952dd270315@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:10:22PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,256 @@
> > +static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
> > +{
> > +	struct btf *btf, *vmlinux_btf = NULL;
> > +	__u32 nr, type_id, cnt = 0;
> > +	void *root = NULL;
> > +	__u32 *ids = NULL;
> > +	int i, err = 0;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return NULL;
> > +
> > +	if (mod) {
> > +		vmlinux_btf = btf;
> > +		btf = btf__load_module_btf(mod, vmlinux_btf);
> > +		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> > +			btf__free(vmlinux_btf);
> > +			goto out;
> > +		}
> > +	}
> 
> [ ... ]
> 
> > +out:
> > +	tdestroy(root, tdestroy_free_nop);
> > +	btf__free(vmlinux_btf);
> > +	btf__free(btf);
> > +	return ids;
> > +}
> 
> Does this code double-free vmlinux_btf when btf__load_module_btf() fails?
> If btf__load_module_btf(mod, vmlinux_btf) fails, the error path at
> ASSERT_OK_PTR calls btf__free(vmlinux_btf) and then jumps to the out:
> label, which calls btf__free(vmlinux_btf) again on the same pointer.
> 
> The first free happens here:
> 
> 	if (mod) {
> 		vmlinux_btf = btf;
> 		btf = btf__load_module_btf(mod, vmlinux_btf);
> 		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
> 			btf__free(vmlinux_btf);  <-- FIRST FREE
> 			goto out;
> 		}
> 	}
> 
> Then at the out: label:
> 
> out:
> 	tdestroy(root, tdestroy_free_nop);
> 	btf__free(vmlinux_btf);  <-- SECOND FREE
> 	btf__free(btf);
> 
> The btf__free() implementation in tools/lib/bpf/btf.c checks only
> IS_ERR_OR_NULL(btf) and does not guard against already-freed memory,
> so this would trigger a double-free that glibc would detect and abort.
> 
> In the current commit, get_ids() is only called with mod=NULL from
> test_link_api_ids(), so this path is latent. However, a subsequent commit
> (4dda98b9e4d0, "selftests/bpf: Add tracing multi skel/pattern/ids module
> attach tests") adds a caller get_ids(bpf_testmod_fentry_test, cnt,
> "bpf_testmod") that activates the buggy path.

yep, double free, will fix

jirka
