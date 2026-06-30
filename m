Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B23A3F0AB6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830918; cv=none; b=YPSE0g2HV5Q3Z9GGYVhsLnW0myyQ+gF16uni4cs62iG5rREXpac3Q9M92VD0HHTdt6gzKia7aXiqH/viq5igBAjTZWQylQsws6FQSCdkPdCsvL+5VM8Ip4k9VqdMWim7FLKzSCirGqJigD5gdI/q8mPItJjntiKMtNnvX8MZwfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830918; c=relaxed/simple;
	bh=1Jj/c/TOCM9F8C2420YyNj+4Ly0pxwW5lqXFrBHZorY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaJeWfuzNou7hAJERuyCI18rPY2SShSpqv6ldTU4JZ5chaL9P63i5Lc45AaNMAveOIqBuTkwRUwQSVnzJcgaohR+twe1/oAty1Pzn35A+WarFsahpYut53sZMVRk7O8XcRX0ggUdo74cdRhNDhWkDToqlIOPcnfR5YSf/FP/Qmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMt8z6b4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMt8z6b4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493a7bd27c2so22297475e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830916; x=1783435716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m03AIVt/lARsmyZNqaerMYeWdNxHnC4KuUXFWS8CSvU=;
        b=AMt8z6b4VBsSDvxJzJSry6DANpmVvMjvWG0UFsaWG2W65aGWs7dGAMXOPb2iu/kVzG
         6Pw7vbngT+54s63gaw23ovptmlxvhX6PhdicVf38O1B3YYwBJ/ZDbNydQzvHm+WMlpxj
         0wLh7Ct3MEJBMMaRkjDRiNW5+G0n7uQUkk5EjlU3uv36sX7+3nKNWoN7WOkpsPBxmATF
         iwl2ewUise/Pdtg3Eakv9jCzqP5syCOGTj6XNaObvJvhPSVKW5SUjVHO8HUc/Klp6TCq
         QEx7Q/BrQEBAWV7WOZ/fg/dRekMA0U8eBJCErdCbJNG0gUMoHQMZC2DkUSTWRLSyAYD2
         Jxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830916; x=1783435716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m03AIVt/lARsmyZNqaerMYeWdNxHnC4KuUXFWS8CSvU=;
        b=pGK7mVsDsy/qeVT8hus3GOkzYIYv1ldhRfrtpdQCfA8LIZW6DbaUGr7epuBPC+4AVd
         YuOKKz+YnxmtiMsdIrKZREGBvNHLV3MaD/ERdzMSTdDsRUmlIVgg25HP7w6/BGAT/8PU
         WxwdDU6jamE5izc8sPzWUjanIYEunmpTcPs/lk27cQBPBAsSSVzlY8JHcJoEIVf8I/cI
         2zebXHntz4SUfOIvmwSnFKFzjNG1KA0TT/Iwe0gkylDn+R09xonelhOENmOynBkNxmpu
         prRUsaqiml6VREhUQPlSGhduyIV8FRHe44SEtYZlr1I5kN9+fr38yGU+at3w1gkIYe0s
         bKwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/21vEQASljEMNaGr3oNJqTh6h7eN+QFterI9xpg1fJU7dOiLbcbwjh6kGI1O20GglsQ1dSDss2VdkUp+cZfP51nCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55GlQC9nSmx5WGjDVXndBTdXzbKRHJoPXKEW12rm/NPM3VqRv
	82Gx1ZYvJvVZ8az+6rj/5J3SDNFPJShuCx5zsKLMa0TKK8ucwHFwM2wc
X-Gm-Gg: AfdE7ckMrYURmx4s3xt4PhuF/Qy/U/hPDGF470EwX36d1ihZ/Y+iKIsEn7zNkivU5dc
	WdAlMvA4EdxXDhfNPytkrEzQ0WmP7XqwPzT/GZLm5Zk3OluRbogZJJBIcXqne0dE7/tTOv4T3f0
	8yRXQqgLZVLg00lUGyiBzC5MTFXEegufkmUYCn48N4QcruJNJdWCS//NLSGpseSTuQKID2CxESp
	8pFzyUCyr7swlXX59jqQDgDnUzbLFwqbb6a0hIjkFaOBJ+pAzwRQsacMdBw2nTViq8Q1c7V6iBL
	TQLJ+PVYM31YykXd2NINg177c7dwWMSrAJnOxpgPzw42VDq+avtwagyQ5yzsCKul8Pis6yTePKL
	xfkgYB4hlZmf6PjkrBQL7ISl2CbvBbNBen7Gv84IT69htyIt0F/FzQv+77C6FCNCLphVjYWvrfz
	S7M+XtW2VoF/5Me3wE70Xn2RHt
X-Received: by 2002:a05:600c:811a:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-493b82aedf7mr51812715e9.20.1782830915394;
        Tue, 30 Jun 2026 07:48:35 -0700 (PDT)
Received: from krava (37-188-177-177.red.o2.cz. [37.188.177.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4dd77bsm188855e9.10.2026.06.30.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:48:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jun 2026 16:48:30 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <akPXPhXIf6Vz76Xc@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
 <aj5JuH6AtjDtWIVU@redhat.com>
 <akJNZN9gvZ30zKUf@krava>
 <akKf511eknMCE0AB@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKf511eknMCE0AB@redhat.com>

On Mon, Jun 29, 2026 at 06:40:07PM +0200, Oleg Nesterov wrote:
> On 06/29, Jiri Olsa wrote:
> >
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -265,6 +265,10 @@ static bool is_prefix_bad(struct insn *insn)
> >
> >  		attr = inat_get_opcode_attribute(p);
> >  		switch (attr) {
> > +		case INAT_MAKE_PREFIX(INAT_PFX_CS):
> > +			if (insn->x86_64)
> > +				break;
> > +			fallthrough;
> >  		case INAT_MAKE_PREFIX(INAT_PFX_ES):
> >  		case INAT_MAKE_PREFIX(INAT_PFX_DS):
> >  		case INAT_MAKE_PREFIX(INAT_PFX_SS):
> >
> > or we could just skip it for nop10.. maybe that's better
> 
> Well, if you ask me I'd agree with the "maybe that's better" plan ;)
> I mean... I don't think that INAT_PFX_CS should be "special" in is_prefix_bad.
> 
> But, whatever you do - I agree, feel free to keep my r-b.

I ended up with the bigger change below, wdyt?

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 92626fce06a9..521a120a0c78 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -266,6 +266,7 @@ static bool is_prefix_bad(struct insn *insn)
 		attr = inat_get_opcode_attribute(p);
 		switch (attr) {
 		case INAT_MAKE_PREFIX(INAT_PFX_ES):
+		case INAT_MAKE_PREFIX(INAT_PFX_CS):
 		case INAT_MAKE_PREFIX(INAT_PFX_DS):
 		case INAT_MAKE_PREFIX(INAT_PFX_SS):
 		case INAT_MAKE_PREFIX(INAT_PFX_LOCK):
@@ -275,15 +276,9 @@ static bool is_prefix_bad(struct insn *insn)
 	return false;
 }
 
-static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
+static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn)
 {
-	enum insn_mode m = x86_64 ? INSN_MODE_64 : INSN_MODE_32;
 	u32 volatile *good_insns;
-	int ret;
-
-	ret = insn_decode(insn, auprobe->insn, sizeof(auprobe->insn), m);
-	if (ret < 0)
-		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
 		return -ENOTSUPP;
@@ -292,7 +287,7 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	if (insn_masking_exception(insn))
 		return -ENOTSUPP;
 
-	if (x86_64)
+	if (insn->x86_64)
 		good_insns = good_insns_64;
 	else
 		good_insns = good_insns_32;
@@ -1620,16 +1615,26 @@ static int push_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
  */
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long addr)
 {
+	enum insn_mode m = is_64bit_mm(mm) ? INSN_MODE_64 : INSN_MODE_32;
 	u8 fix_ip_or_call = UPROBE_FIX_IP;
 	struct insn insn;
 	int ret;
 
-	ret = uprobe_init_insn(auprobe, &insn, is_64bit_mm(mm));
-	if (ret)
-		return ret;
+	ret = insn_decode(&insn, auprobe->insn, sizeof(auprobe->insn), m);
+	if (ret < 0)
+		return -ENOEXEC;
 
-	if (can_optimize(&insn, addr))
+	/*
+	 * No need to check instruction in uprobe_init_insn in case we
+	 * are on top of optimizable nop10.
+	 */
+	if (can_optimize(&insn, addr)) {
 		set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
+	} else {
+		ret = uprobe_init_insn(auprobe, &insn);
+		if (ret)
+			return ret;
+	}
 
 	ret = branch_setup_xol_ops(auprobe, &insn);
 	if (ret != -ENOSYS)
