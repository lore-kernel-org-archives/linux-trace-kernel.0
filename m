Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC62330D35
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931290; cv=none; b=RlAGMtZG4gohVhTjhwaaCcqkNfaNL0zg3wekW51dPwL8dxLHpKLLyVf+LctBfu+VRT8+0vJMhYXZMpVoL+VBmLFFAtrdEAzUqTWb1yvm4zuum0/+syKZ1+eMDY+RZ171D6AEmGGpyxp/1tlRmNw20WhNa+gTwCQXDsmq5nzwDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931290; c=relaxed/simple;
	bh=zsVAQYohKLsk3CpzCDHomDfvo2cGUL3Pm93kc9liwFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=QBMaTTwEteq95drqsDuOwkwzzeKwT+4MHKRbTgqSFp1t9FCE89BUSWnk/qbyrcwB7nnucmpYuaO1J0smSPo1DJlwoTCf62HKaVBo/xQy/mGUQ8KPcLu/GJR73QRlx3veDvSoExouBpj0uGnY3inVWiBvF/DLd6hXgYokxpGnidQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oSJaG81U; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSJaG81U"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a3110f34d1so85658eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782931288; x=1783536088; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apSMst9DB14zD5+2ABKg/MeqMrLAEvfuLdfp3VOuDI4=;
        b=oSJaG81UiFt58Nj7hz2ShvE6Muet7Ej0FkGHNTNxqIv7xTazTR+34spIm1rR6f3FgQ
         7aMaCWR/dt6hHNpXSf8pelsz9m87kZUc9a9Hl0zI5lzTH7dLvbbkfI+SeKn7PZAcdMs3
         ZXC4sGbkyhZZhb4pJR5W864OyPP9k8viSL3VHuJ07wiEYGXFhdJOOsSQHvbxI/BVQind
         NOt5GKCfZwQwEuNzF0LBzEwqb4eECfbrIOtzFZH+IVhOStAJLlgPpk6uBwk0BM92X2yj
         nPCBEyxttdjKLQ+pSQPzJHH5lz4pDv/EnQMPgmMjnz5tvcDUGnXtPedVlSmmh3kugUMl
         bKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931288; x=1783536088;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=apSMst9DB14zD5+2ABKg/MeqMrLAEvfuLdfp3VOuDI4=;
        b=L6oj/3JrhYlsQJ6Ui6nXfrtudZFQOakktRUiKGH+YNqWYIKuRD33M23eX+hhutZoYm
         9WXLWYUdNkJyXtz21gKpQETFaRj1NiHIE+bn7hq5th6+BGYN0PvpHKn8H8TF05apBoKU
         Xwr1Bj6PQghOh+7jxgALspGZGdg7Z1bUARSV0RblrJV7yHr1uiie7PH5TMgP6/y2IvRS
         gA0Rmc0x7rfKbhUaxMgpNg6RArMtGJPRFeN7n8ZyQEHUPjEGwgLOOJaBz5havACQR0y4
         Oxl6JlmbqFoJPuNfaPjiKFBPCriyOZF2JCsXLeKvnkn5q8o/jmsNP9oz4FodAFFH4vB0
         YcZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4184KTy1Jx5bolI5txg6KxhE4U+2hsDKDjOLKirzAEjsQGujaapkqugwZZMI0QxWGDGGH+AaEe7KHvYixbRMJfPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVRCJuCMrv9QxQEYonNOa52u7o0N3X6HwX03wb+Xg5zcjUWwjZ
	yiU75eUqx8oIzylkdILQTXfMXmhpCM+67nLVjB/FBgSPORJKK8V/f0Sg
X-Gm-Gg: AfdE7cluGJA/WwiDJXED+utLUItq3tIvUiQRKsTeD0j8ab5nrgxYWLW9OT2vaWyX7Lv
	vZSiU20TCL3zB9qRnAFHnh/uKOUgs72smGJkV5vIONpqZO1Fg6uQrX4WpTMSiC2Tt2xJduwlDox
	4yAiGrmSQQOERqflEX8EvsWS6xeC4EDG8QsIbMtVy2s7xoAgzV25N9e8IXVy4r3aabOfye2unHX
	9ZeOQ2e2Qquz6trvR9PzYdYdJu54NCsnFz33db/5dgZRY6Qe46SE1dY1IlJeAq2zQAXXZA2bUaE
	gtcYgZ99k0IFbokVL9GncQ65XgUZsbrSyUvHd4WHFC/mrLYfGXtADRUAcfq7uuo+oen1L9WfGe6
	Si2iqEl3/MR1RF7f0uiUSx2IZftx/7kIY6u2GNaFJLY2Hf0KyNjBhH2yzc2lgzTG+ijhuJ+v7rD
	1jOEIiCT0uWW7QW2sh+1iHCR0knUnh3xh5+RdOp22raovbteA/h//0MFAiKTNHOZSvT7RXOouco
	jbuXZU=
X-Received: by 2002:a05:6820:1f07:b0:6a0:f0a1:568a with SMTP id 006d021491bc7-6a309ae6e59mr1595301eaf.43.1782931287563;
        Wed, 01 Jul 2026 11:41:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbe8d9a7asm483692fac.6.2026.07.01.11.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 11:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 11:41:26 -0700
Message-Id: <DJNGE5JG5ZY4.FEO5DZ21TL7Z@gmail.com>
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a
 single BPF program per event
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Shuah Khan" <shuah@kernel.org>
X-Mailer: aerc
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
 <178291354144.1566898.14374948740441958770.stgit@devnote2>
In-Reply-To: <178291354144.1566898.14374948740441958770.stgit@devnote2>

On Wed Jul 1, 2026 at 6:45 AM PDT, Masami Hiramatsu (Google) wrote:
> +static bool trace_probe_can_compile_bpf(struct trace_probe *tp)
> +{
> +	int i;
> +
> +	if (tp->nr_args =3D=3D 0)
> +		return false;
> +
> +	for (i =3D 0; i < tp->nr_args; i++) {
> +		struct probe_arg *parg =3D &tp->args[i];
> +		struct fetch_insn *code =3D parg->code;
> +
> +		while (code->op !=3D FETCH_OP_END) {
> +			switch (code->op) {
> +			case FETCH_OP_REG:
> +			case FETCH_OP_IMM:
> +			case FETCH_OP_DEREF:
> +			case FETCH_OP_ST_RAW:
> +			case FETCH_OP_ST_MEM:
> +				break;
> +			case FETCH_OP_ARG:
> +				if (regs_get_kernel_argument_offset(code->param) < 0)
> +					return false;
> +				break;
> +			default:
> +				return false;
> +			}
> +			code++;
> +		}
> +	}
> +	return true;
> +}
> +
> +static void trace_probe_compile_bpf(struct trace_probe *tp)
> +{
> +	struct bpf_insn *insns;
> +	int i =3D 0;
> +	struct bpf_prog *prog;
> +	int err, idx;
> +
> +	if (!trace_probe_can_compile_bpf(tp))
> +		return;
> +
> +	insns =3D kmalloc_array(512, sizeof(struct bpf_insn), GFP_KERNEL);
> +	if (!insns)
> +		return;
> +
> +	/* Prologue: R6 =3D ctx */
> +	insns[i++] =3D BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
> +	/* R7 =3D ctx->rec */
> +	insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6,
> +				 offsetof(struct fetch_bpf_ctx, rec));
> +	/* R8 =3D ctx->data */
> +	insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_6,
> +				 offsetof(struct fetch_bpf_ctx, data));
> +	/* R9 =3D total size (0) */
> +	insns[i++] =3D BPF_MOV64_IMM(BPF_REG_9, 0);
> +
> +	for (idx =3D 0; idx < tp->nr_args; idx++) {
> +		struct probe_arg *parg =3D &tp->args[idx];
> +		struct fetch_insn *code =3D parg->code;
> +
> +		while (code->op !=3D FETCH_OP_END && i < 500) {
> +			switch (code->op) {
> +			case FETCH_OP_REG:
> +				/* R0 =3D *(unsigned long *)(R7 + code->param) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, code->param=
);
> +				break;
> +			case FETCH_OP_ARG: {
> +				int offset =3D regs_get_kernel_argument_offset(code->param);
> +				/* R0 =3D *(unsigned long *)(R7 + offset) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, offset);
> +				break;
> +			}
> +			case FETCH_OP_IMM:
> +				insns[i++] =3D BPF_LD_IMM64(BPF_REG_0, code->immediate);
> +				break;
> +			case FETCH_OP_DEREF:
> +				/* Add offset: R3 =3D R0 + code->offset (src) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
> +				if (code->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
> +								   code->offset);
> +				/* R1 =3D dst (R10 - 8 on stack) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
> +				insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8);
> +				/* R3 =3D size */
> +				insns[i++] =3D BPF_MOV64_IMM(BPF_REG_3, sizeof(unsigned long));
> +				/* Call copy_from_kernel_nofault(dst, src, size) */
> +				insns[i++] =3D BPF_EMIT_CALL(copy_from_kernel_nofault);
> +				/* if (R0 < 0) return R0; */
> +				insns[i++] =3D BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
> +				insns[i++] =3D BPF_EXIT_INSN();
> +				/* R0 =3D *(unsigned long *)(R10 - 8) */
> +				insns[i++] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8);
> +				break;
> +			case FETCH_OP_ST_RAW:
> +				/* Store R0 into R8 (data) + parg->offset based on size */
> +				switch (code->size) {
> +				case 1:
> +					insns[i++] =3D BPF_STX_MEM(BPF_B, BPF_REG_8, BPF_REG_0,
> +								 parg->offset);
> +					break;
> +				case 2:
> +					insns[i++] =3D BPF_STX_MEM(BPF_H, BPF_REG_8, BPF_REG_0,
> +								 parg->offset);
> +					break;
> +				case 4:
> +					insns[i++] =3D BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_0,
> +								 parg->offset);
> +					break;
> +				case 8:
> +					insns[i++] =3D BPF_STX_MEM(BPF_DW, BPF_REG_8, BPF_REG_0,
> +								  parg->offset);
> +					break;
> +				}
> +				break;
> +			case FETCH_OP_ST_MEM:
> +				/* Add offset: R2 =3D R0 + code->offset (src) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
> +				if (code->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
> +								   code->offset);
> +				/* R1 =3D dst (R8 + parg->offset) */
> +				insns[i++] =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
> +				if (parg->offset)
> +					insns[i++] =3D BPF_ALU64_IMM(BPF_ADD, BPF_REG_1,
> +								   parg->offset);
> +				/* R3 =3D size */
> +				insns[i++] =3D BPF_MOV64_IMM(BPF_REG_3, code->size);
> +				/* Call copy_from_kernel_nofault(dst, src, size) */
> +				insns[i++] =3D BPF_EMIT_CALL(copy_from_kernel_nofault);
> +				/* if (R0 < 0) return R0; */
> +				insns[i++] =3D BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
> +				insns[i++] =3D BPF_EXIT_INSN();
> +				break;
> +			default:
> +				goto out;
> +			}
> +			code++;
> +		}
> +	}

Nack.
I really don't like it.
There were days in the past when the kernel generating bpf directly was app=
ealing.
These days are gone. Performance improvements for fetchargs is not a good r=
eason
to add all this complexity and bypass verifier checks.
bpf insns should come from user space.
