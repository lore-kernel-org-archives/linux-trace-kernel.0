Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC9372696
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117829; cv=none; b=Lgz2Iq4TUh2YXSqb7ZfPI7il9u2Sjz4AvdQyAvSByq+7TsUq5dp4cfds2TquzPRov6MDE5IzOqNlGtHS/G2vlQINhM3wLMnnCJkkdtTYTsGBdib/JfL2iyL2GhdVitlbredPbkafcv6RLQUMMoJHOxArfiC+Vl7Qiw3d3+J/Q7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117829; c=relaxed/simple;
	bh=gaTlWhDUM2MSwAxeLBy6jHCOOij2tIwMSU6UMacPRe4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BtXGYIKFPqX7AsBbVW5IVFFPIayrf78g3FqRg9VAFTP8MYiMmhmlDzYRlX9XpeRfRBJnl9k0e1aG9NItpuixUf/GvxRHoZRmXid9bNALy0Pl6SXs5trOHo1IAxguKw7m/NYMhTrwgUugkFdh7EtgiMTfP4cPMP8kqWo5HZ6Vzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKDNc1gY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKDNc1gY"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd3eb594960so306475366b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117826; x=1779722626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3bxqxR3AS/2mlWCDns0dPxr0ZlNjufnWjuWtLIrpczg=;
        b=WKDNc1gY/Z7YIZ3+KlyxWmu+8kCuV0oTQxeF5MsQmlq0+IciOJKU9dry5h+O32HQpc
         8ixqWzcvVxOo02+nKtHL221jbX7ysw+IY8QFMwNxXHuxcg68XGw+wV9gAlwo4Y5LHRLU
         csyPz32YfGm9BavTd8dR+rA/mJJ+5IPph5TebI/hKYn5gEbn2qI1iBzp8/fddyEXc3Nx
         VQgLLynaaX+Iw1usNorkiHfjYJ5jWv9072RnUSmrRMOpHPLjh43LepePSr4VBM4goB8d
         ZqztRyKjsrci5BdKfeS4BR2rbRqWWB0UydOS8Hld+MS8UXZydfoIUjJSq8olbiAbKev5
         Rx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117826; x=1779722626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bxqxR3AS/2mlWCDns0dPxr0ZlNjufnWjuWtLIrpczg=;
        b=LEGpj98y7Y94Op76L14weyLFi2vw5XDRLAQ3RtoU1fip7dqW3TkTUhKqoBW5preQ+3
         fhBsG/pP7rb/N/dyPoXzovZkIu48qH3nO0Ar+MApzeFp8EkRNPO+JKBvylmf/bAzM4EO
         vPeh5M173srZgrpmjmA4rjQT00qFra1FLbV//rCbro5mKX4BHjPiSEJsj/PiHPkmlTvT
         ZXxNq+0f/DMfSuJvCBblDasmzomhyPjDd/JhEGC58z4A3dUXkfaHGuyY4OuQ+0ec1iCx
         GLLKs9lmPmN0gFdY8fIjJqjPR8JMV6Fhhz+y3P5iYlATKYE0I81wa93k/iLczngcu4zb
         xjew==
X-Forwarded-Encrypted: i=1; AFNElJ/lUbg0iBB46HQQaQKjbriH/15JOkYWBZNMi1+IDMSOZP4fklGoN+3EbD8GMZXGVTeTpG/55Jchp0w+dnCjiAvuEX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhq/DnZTfewNgaCokOtgXeCxTOQfHmVdXenxBvlX91eRvNZsP
	jPDqQnJ5iLge/konQoSEV16yUo751n79iftx/ITpOKh1IOzRniXhTthC
X-Gm-Gg: Acq92OFqoN6BExF7tL+pQdF1YsuXPOYtYN0DTQXrtrNNuCTJprtuXR900gMNzcml1nM
	blYd+E3v4fGQP6SLGcQuGsS6Yi3HGFSJi2k3iSkR1cQBdPAZyWrI42WjMh6IMkV1h8Jw5YwNIJF
	D1nMz5LurIZnR7mqiarYpdahPKYszkzfBWYhJBgG2NmVgGIfNLouCm56yzW8omKG8tqqncxUMwU
	0WmZzRI00zKRnVIVoPl7ufNF1nhsVf2sdNfCxPR1APnH+h7BHU6kDVGULF7DiIDfXeAV8ZcionE
	tpExU9xMwMU3dwIgrV0v+G+znQNqS09H+j07n4CGkWAvUuiBeokF18zvslZ1cLnVnoZkroG+rl1
	fBiaieC4sb3hzlZWCoILEU1NX08f7Yb+Z/K+ypEJGqHfcD9mqcBzu2LZNOYR9AnrRJWEaVIzWjU
	v5h3AMRij5hxrXyijpJ2tRTD0=
X-Received: by 2002:a17:907:9999:b0:ba8:8094:f7af with SMTP id a640c23a62f3a-bd517812fdcmr796848666b.18.1779117825737;
        Mon, 18 May 2026 08:23:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4c2a68dsm588949666b.18.2026.05.18.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:23:45 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 18 May 2026 08:23:15 -0700
Subject: [PATCH bpf-next v2 1/3] bpf: Make btf_get_module_btf() and
 btf_relocate_id() non-static
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-generic_tracepoint-v2-1-b755a5cf67bb@meta.com>
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
In-Reply-To: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779117822; l=2153;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=B2Q5ZdB7pM61onhNlASrW+XT54jXtCSbdxoU2W8BpA8=;
 b=3UM/WMEqfUZy/QNX52QX2pquJZvkUYkn8JDeu6XnMJZ6PFrIhTD2XJLkDMO/5xJwyLFEECdHQ
 Ew/Q4xqOPWECNEzdWiE84NSIaYEw/jNLEaR85szTDbPo7X9wo7GOEgH
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Drop the static qualifier and add prototypes to <linux/btf.h> so the
tracing core can look up module BTF and translate ids stored by
resolve_btfids (which are local to a module's split BTF) into the
runtime ids used by the kernel.

Used by the upcoming events/<sys>/<event>/btf_ids tracefs interface.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/btf.h | 2 ++
 kernel/bpf/btf.c    | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 240401d9b25b..273a93a3b2bd 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -235,6 +235,8 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
 s32 bpf_find_btf_id(const char *name, u32 kind, struct btf **btf_p);
+struct btf *btf_get_module_btf(const struct module *module);
+__u32 btf_relocate_id(const struct btf *btf, __u32 id);
 const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
 					       u32 id, u32 *res_id);
 const struct btf_type *btf_type_resolve_ptr(const struct btf *btf,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 17d4ab0a8206..4c33dc7b0aef 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6429,7 +6429,7 @@ struct btf *btf_parse_vmlinux(void)
  * split BTF ids will need to be mapped to actual base/split ids for
  * BTF now that it has been relocated.
  */
-static __u32 btf_relocate_id(const struct btf *btf, __u32 id)
+__u32 btf_relocate_id(const struct btf *btf, __u32 id)
 {
 	if (!btf->base_btf || !btf->base_id_map)
 		return id;
@@ -8496,7 +8496,7 @@ struct module *btf_try_get_module(const struct btf *btf)
 /* Returns struct btf corresponding to the struct module.
  * This function can return NULL or ERR_PTR.
  */
-static struct btf *btf_get_module_btf(const struct module *module)
+struct btf *btf_get_module_btf(const struct module *module)
 {
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	struct btf_module *btf_mod, *tmp;

-- 
2.53.0-Meta

