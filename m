Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA43595C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019349; cv=none; b=by421DmIuInX8K8XDsmZ1kZa3yJfKYg61d5IygAH7bS9F5v4vJGkakfz1ewRhFWeI1YFF4I56PwdIw3JoYi2+rZMMOduvPiEqhhiDyDTtlBRXVKRpHKdmIK4q+xUNiLTcZN5bhUbKoGVfNbihdHVitCL8QjWDXbP0TnPUDsRxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019349; c=relaxed/simple;
	bh=PscVuWbDY5Tey7C1/LRHtZVsPLJIK/L06l4kRlXD7cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/WQoESaA/crJx2RDZ9Bj1bcFFC71SRk1fiqvY9UHWmRNHYZlJLU9eoC7IpE4x7JNfAhJjUH6tRI4gsDP5B32EHbuITb3DYwYbgCejE2zpWP2Jm3qRsm6I+2gGmcF3iC7hVcVijLhu/whVdFGPhsZuXHetEVize1DKR2aV8bzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK64JsLv; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK64JsLv"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b632a6b9effso641821a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760019347; x=1760624147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/LQvNA1YWUI5q9qNOI8bo009IJa0hh1gjwEZQ8TVg8=;
        b=jK64JsLvHEsDt/vMFjU1YlG6MpS7JrD9vbTdSj75MaHr6CoB593E9F2SpFpYZ4Zkfs
         za7k1woge8FLyhc4kj5XO0xMSCubb3ble+XazYPdnQuDjZwh297na+3ej6dTeAYuD0t0
         m8Ij590/JuT4jdK0eIdI2pTVmtmbpnQvOIY6fW8ro9goJHSxs9gYSW8XMKGTeJe8/hU5
         6IRx/Zq0Fh6NdEuOnBloHNF/KI8Zeaqj8slHkJPcnk1GJBWNdytwfZOw8h1ODguaV/eK
         VBJtxjSRQOMxJdOOyVHGhgF3KgD16T6mwVR0r5H/DmKrZbm6b6F9IsVPA/DXWVW5dvOC
         mSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019347; x=1760624147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/LQvNA1YWUI5q9qNOI8bo009IJa0hh1gjwEZQ8TVg8=;
        b=eHLVpEwTCRmyJyVg8NIOjV2go42nGT+eD/slBC8j1j53+8Q2DzDYaDSnQ6GwevTPUp
         pYNhk0/Y8+Rzatsru0xYdO38GeIgG6Z0Lq3XBclCXrrLpQz44pwgGKy1P2z+B1Mb2NGz
         gRSakH3upK5bxGWj+lLNiLZQtasQge1Snuc8+GLEYXBCsMw3G9xiaokAo33A0hGWcn9e
         /0Rtuirg6ODtD5KHW+N3tH4s1RoxdlVHRptCpqoyaB/N069Zyjx8I+GqT8WW6RdhdKBl
         sQTIrTN+lOc9ecxUeGGzhcfvEZhngMJrp9QdIEZDXWidiH/U6KqP6e4a/0pQZF2XP/Iq
         i89A==
X-Forwarded-Encrypted: i=1; AJvYcCXfvZOFRPyjEljH3I9DuNnvDO5w1bU7YtJ8qr21tha54bgUr97VBcvOPyLdovdT7gKquP6SmHupRmdA+EiU9Y/6Tzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH42z0zh7yKHd4Op3b/53GCtDddZ/iuMPbyrPaiUbgQuCb9chF
	nOD/Y9/HPTRyAKzwGh4I+ZH8BWDiqcG45ZYFvLzZSKYQ20YhfEXEBqbsg8RInVlG
X-Gm-Gg: ASbGncub+b+HLqpwM6bOgWznlyIb5qtclCqi/Mf8B0fbq98mM9nzsQzjiJJ65fjT9f5
	1G4spGXwYW2bSgxqIvtpcjzS/RM2SIXlS265H81VUDeDn45RFE3G93wQlGcpTzSH5wz5zYADC7n
	H7Vuk1x7+HfsCn1Q+7rlQNWSZXjCsbTap8H5TNZY5LOq5/49QXANEi7G6c/je738ly7YscJdSry
	yjOn14PXQnZB6tLztOKMg1s5oxgit6AmS3HCyZUChg2AnkbgdMd2EXchY8DWHJoMzbx1mR81g5L
	XUG8rce5gPbKopR1y/Tt0I3IbzVizauskPczH50nkiW45VKPFuF7d6F4jRo63ZBoxaCU8Dbs6Lw
	oeBw+brr/rwpnlZhLQrHn4rtDaN5RU3H3Aij5NoWd20MwJvXJYVw+c3GXN0g=
X-Google-Smtp-Source: AGHT+IHBBobTahYvaG84K3u2cRlq7Kyd8joS3YBPhCwvTmS1PRGSMWiLL+j+NCjFMod+mD0mklz8ww==
X-Received: by 2002:a17:902:f612:b0:277:9193:f2ca with SMTP id d9443c01a7336-290273564e8mr77424185ad.9.1760019346826;
        Thu, 09 Oct 2025 07:15:46 -0700 (PDT)
Received: from [172.20.10.4] ([117.20.154.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f0726asm30309915ad.72.2025.10.09.07.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:15:45 -0700 (PDT)
Message-ID: <405caf71-315d-46a4-af35-c1fd53470b91@gmail.com>
Date: Thu, 9 Oct 2025 22:15:34 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>,
 Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev>
 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/10/9 00:27, Alexei Starovoitov wrote:
> On Wed, Oct 8, 2025 at 7:41 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2025/10/7 14:14, Menglong Dong wrote:
>>> On 2025/10/2 10:03, Alexei Starovoitov wrote:
>>>> On Fri, Sep 26, 2025 at 11:12 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>>>>>

[...]

>>>
>>> Leon suggested to add a global errno for each BPF programs,
>>> and I haven't dig deeply on this idea yet.
>>>
>>
>> Yeah, as we discussed, a global errno would be a much more lightweight
>> approach for handling such faults.
>>
>> The idea would look like this:
>>
>> DEFINE_PER_CPU(int, bpf_errno);
>>
>> __bpf_kfunc void bpf_errno_clear(void);
>> __bpf_kfunc void bpf_errno_set(int errno);
>> __bpf_kfunc int bpf_errno_get(void);
>>
>> When a fault occurs, the kernel can simply call
>> 'bpf_errno_set(-EFAULT);'.
>>
>> If users want to detect whether a fault happened, they can do:
>>
>> bpf_errno_clear();
>> header = READ_ONCE(skb->network_header);
>> if (header == 0 && bpf_errno_get() == -EFAULT)
>>         /* handle fault */;
>>
>> This way, users can identify faults immediately and handle them gracefully.
>>
>> Furthermore, these kfuncs can be inlined by the verifier, so there would
>> be no runtime function call overhead.
>
> Interesting idea, but errno as-is doesn't quite fit,
> since we only have 2 (or 3 ?) cases without explicit error return:
> probe_read_kernel above, arena read, arena write.
> I guess we can add may_goto to this set as well.
> But in all these cases we'll struggle to find an appropriate errno code,
> so it probably should be a custom enum and not called "errno".

To avoid introducing a global errno, here's a more lightweight approach:

1. Introduce an internal BPF_REG_AUX and a helper
   'bpf_jit_supports_reg_aux()'.
2. Introduce a kfunc 'int bpf_reg_aux(void)'.

When a fault occurs, we can set 'BPF_REG_AUX = -EFAULT;' in
'ex_handler_bpf()'.
Otherwise, 'BPF_REG_AUX = 0;'.

(Alternatively, BPF_REG_AUX can use a custom enum instead of '-EFAULT'.)

If users want to check whether a fault happened, they can do:

header = READ_ONCE(skb->network_header);
if (header == 0 && bpf_reg_aux() == -EFAULT)
        /* handle fault */;

This allows users to detect faults immediately without any extra global
state.

The verifier can rewrite 'bpf_reg_aux()' into the following instructions:

dst_reg = BPF_REG_AUX;
BPF_REG_AUX = 0; /* clear BPF_REG_AUX */

As for the architecture-specific implementation, BPF_REG_AUX can be
mapped to an appropriate register per arch — for example, r11 on x86_64.
The verifier would ensure that BPF_REG_AUX is not clobbered after a
probe read.

As a result, this avoids the need for a global errno and introduces no
runtime function call overhead.

Thanks,
Leon
