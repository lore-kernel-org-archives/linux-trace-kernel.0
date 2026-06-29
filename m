Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D66346E40
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730093; cv=none; b=is7auSc0MKCEPmUgbo7M5hzPfDrnYPnLNA3ePkwl8ypWBqTt34YQt/AbIETfLVYrANNAY/z7HrRN7peptnHyJyX8/UPuFNQNZrFuQNcUgGOe2x01qABr3OMQuQ4m9e+dN0iQhJ/Rd1+BskZWntpOPf6h8u1HxU1AoECcLZ3BUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730093; c=relaxed/simple;
	bh=XKB1LYQZvcxMVEZmqcVxO331yy1FWJxkxDIGIuobqfQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVscNt+CYqcsbmAnIGEhYsMpxZS0XEpVCYYg6bNkSLqSHx0aIjlXOqtkd9gCFm3HA7pdHI1CFagK9zkiRZp3bgOJS3QHSX0HJTyQyb5ZId4RZQu/cTpF6aY82A+k6r5q/bi1wuQS2Llk3VacAxkFu4FP1NA89yBbBRdLq7fIqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAjccFbW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAjccFbW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46cf972f281so1679795f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782730089; x=1783334889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vf84m9FqsfN+W6JKLSjBPKsfewz0W86jKSdyAEwZFuE=;
        b=PAjccFbW3nAOCEWhINA/BOrQVUvZIwc1amiEboXFuDp05nfCRdT3tlnuynJhnVBLQ9
         L2XOxxGrEhvDZMdb3sWNPxTs2OAsW+NO3ICGIenmiKukQohsi4FzLVLGmlmWAbOq++/H
         U8aYJUxnIjW6p6vzegQ8ywRKC3xGqSac9hNGF0gV63s5cNqRpIWbm+z6Xg0KaVGoSRlq
         1VrAiWfjZrpwURZFC95vkpjsAVg/0qRvW5OLmxKXq3AoIjPLKzakfX1O2sx6lz7p+0uL
         sn7BQux02JGivwnxK8fbquIX1D4Cttb5OiuRCgKLlLPN6yuPFpk5Em3nDkSrftAyOARa
         RI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730089; x=1783334889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf84m9FqsfN+W6JKLSjBPKsfewz0W86jKSdyAEwZFuE=;
        b=iCDGrI5T1zL/OimnVEOam43NJaX7zeJbO8H0hM62+imsTMyBXgZUbldZLCjEXILz67
         aSiLNxCY06jag22W/Gl+c6jlLsRiUpoY+9jcwGeLRidauAmLZECkEAXyCKkjHJGUsukW
         v0bPTHNqGhwfDqrWAfHjBNqnyr9Lz0RJbKFK/PNcEKUIDs6Ea1T3LAERkE6dS30mOFlg
         1hg7xnRQJZnwSQAh25YiMqoM4nZcURuya+6vJX7DUY9FEb12gN1slIozp8LpJp+ZhVzA
         0bvrIIkf0z2jyvFqI6Q3NWHBKRL2WvvF41yp9aAHsA2Iw/zoYwV4WExUBRLl+sX0jklx
         Fnnw==
X-Forwarded-Encrypted: i=1; AFNElJ8ozkn8pIIaZsryfT2spsTm2bi0KbTpQ7IcB8IqA95HtAjEBb6B517EiM6Rpa44M6tCjtz8XYLkt34AmVq6cy7ijA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YycCS7FzGD9mJ6Zp7C+SOQ21R2d0PQlpqsi8+DIyaQko8qpDTzK
	76FrK51UtPRVrsumNcapgyUYbDgNqOS9cXXMBBMU/a0SZoVeOfwHZa39
X-Gm-Gg: AfdE7cmx5lCsBYXZVVakHUbn7vFXu5IaBhaSHJCvV3EbiGCXm/RViOkQAlUqAiEG7bI
	zwpVri9YikyHYSJ8rosQsAfEL4LmDUM6VAnzJ0dZrJJ4YZ5Sk5UpHYDBf3qqifDW4bTKzipG5VV
	ynuBWUZNzFSHO69U66fJsWoO2cUlAFP5D90nE4ex3PxlDfohOjdFYYKAb24M/WcpUj7AOTEWMdf
	+hEkndRRYAO0aeJti1zDLbGkNHfvLqW85Yk7NYF7adSBE2vtxhmt42GeR3OHzRZV5/+TxpffVk7
	cESrLcf6WFJ1TTuWSX+rUWcwRjxjbkKp2KNIYzGdwFFqKjec3nmtxsngJNv2BpFK5nW31BtRMnR
	M4UVGGVchmvkoUnlYzaBrSgEApyUEE4u0b8mQow3BAAPPJ9BLluVqwjYBAvoQdO/aopvvhwDo1z
	FMOkLtgrSdMw8PMuEzr5T3OxNQ
X-Received: by 2002:a05:600c:6211:b0:485:9a50:3370 with SMTP id 5b1f17b1804b1-4926683b1f4mr246816125e9.8.1782730088879;
        Mon, 29 Jun 2026 03:48:08 -0700 (PDT)
Received: from krava (37-188-219-218.red.o2.cz. [37.188.219.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49392c991aesm127359335e9.0.2026.06.29.03.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:48:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Jun 2026 12:48:04 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/13] uprobes/x86: Move optimized uprobe from nop5 to
 nop10
Message-ID: <akJNZN9gvZ30zKUf@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-6-jolsa@kernel.org>
 <aj5JuH6AtjDtWIVU@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aj5JuH6AtjDtWIVU@redhat.com>

On Fri, Jun 26, 2026 at 11:43:20AM +0200, Oleg Nesterov wrote:
> On 05/26, Jiri Olsa wrote:
> >
> > which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> > attribute in is_prefix_bad function.
> 
> ...
> 
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -266,7 +266,6 @@ static bool is_prefix_bad(struct insn *insn)
> >  		attr = inat_get_opcode_attribute(p);
> >  		switch (attr) {
> >  		case INAT_MAKE_PREFIX(INAT_PFX_ES):
> > -		case INAT_MAKE_PREFIX(INAT_PFX_CS):
> 
> I know nothing about how x86 CPU works, so let me ask...
> 
> What if insn->x86_64 is false? Is it safe to allow the CS prefix in
> this case?
> 
> Oleg.
> 


hum, right.. I think we could make it x86_64 specific


diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 04cd2cdce8c8..de60ec1eeee7 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -265,6 +265,10 @@ static bool is_prefix_bad(struct insn *insn)
 
 		attr = inat_get_opcode_attribute(p);
 		switch (attr) {
+		case INAT_MAKE_PREFIX(INAT_PFX_CS):
+			if (insn->x86_64)
+				break;
+			fallthrough;
 		case INAT_MAKE_PREFIX(INAT_PFX_ES):
 		case INAT_MAKE_PREFIX(INAT_PFX_DS):
 		case INAT_MAKE_PREFIX(INAT_PFX_SS):


or we could just skip it for nop10.. maybe that's better

jirka


diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 04cd2cdce8c8..21f26e6fd452 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -285,7 +285,7 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	if (ret < 0)
 		return -ENOEXEC;
 
-	if (is_prefix_bad(insn))
+	if (!is_optimizable_nop10(insn) && is_prefix_bad(insn))
 		return -ENOTSUPP;
 
 	/* We should not singlestep on the exception masking instructions */
