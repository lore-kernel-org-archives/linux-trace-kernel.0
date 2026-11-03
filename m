Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674986;
	b=yCzBT7+GVYU5sE83UIMcL8Js1U8wQosvXkl3z1uBj1dUSOdzvrEK0lLKmepJPsvj6ICX
	 mKF4pp12EtsZ+oPX3IrlMb8/HhfqTiG8wc14G2vyfKY/88hVJ+ba8n4ekHaPV/icnkr7W
	 dAqk6C70Tif0N66ltCyxfwyF1XAKQn/HFpSrGhLm2Tjbf3SWESxE4+XFWE4cEHf6LPATB
	 Hb08Ujq6pJyZJ5kJhtqZNCQ9dzkpd8y9UsdBN4yYpSR1+4Llvt8w+1xwPoQMZR6EtolNM
	 IFOndCa3H5yP21w9OVg7zHNPTwTMW1vQqwRNH9ktKypPRBQ2Xj/Uj7khkYNtlTqW0DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=dIm7BgetdBymH26dv/zJcRvTygJQqs7GO+6HflsoA4U=;
	b=iNAVTFN/EvKygVAmkqEgsY8WEKdiAixhyfNjPq30k5kGq5SISKm1dDX9Een0M1F7fKyA
	 Pl9yB30d3J/YcwumZ01wY2GJ3882EvP7mnDyXTQVWa2MMgMVK5aBuJt64TDWYHGLwd1jT
	 Q2m/RNHwosQ2Bfi2/tC05iUxtb26E6+aqXeW0QlkYLp9jmQxjuczVBvQW/5dwk2t3dKL3
	 0KG69JDpvbuv3iaMQRq5+bjeyIvqz+Jkx8JLJsHChBL1ptyagyv/0hFKkNjojYUW9vjDa
	 Yd1vE8Gv9VNZDsXU+oJ4SfZoKDpojSlAaBt44PM9p0a4mw+5J0XmlkTnNjWXkP0zsPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=To4ZOhDA;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE95606D82F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 03:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE95606D82F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=To4ZOhDA
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so1533812a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Nov 2026 19:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674985; x=1794279785; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dIm7BgetdBymH26dv/zJcRvTygJQqs7GO+6HflsoA4U=;
        b=To4ZOhDA7x492QcabmC8OMVUVMEgqW90desb9Fh/7TmwUxnsh2AC7KpqeVaJ40UKpU
         Rjqd+rjWUymn7Hab6mAJ/HIP17ubpbpmvILQamUZ1N3BdtF0taw/jdJpfCEUpGxW0H4t
         MGyfuywPRTASGKs6QBbfhfrijOqvyn88GBIrU3sijpUTTE4t5NcQh8lnJQQU/ViGxZFR
         a185B2efLhVvjAivY5zNl2KFSDOoeKMEEyRwpjujNk91KVwcpfVRO+6RWNj9n0xmYuH3
         ZLYymj/ntwgkHsQAEQ11vYJ99KKS+rrFfRFjE6G2FCpOlTkwKZQEvYJkmSUPRZ7jCCmn
         CvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674985; x=1794279785;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dIm7BgetdBymH26dv/zJcRvTygJQqs7GO+6HflsoA4U=;
        b=D6dFgfqXR1Efjugusth4OyF0kdmKyVezE81fpN+YksjSQcb1fAZF7RqWY4QF5KZU/e
         sgmbFYqeE3ixSEnndxNJRiZvTDDO7bsgYMPg8yg24UcDrGig8+KKGaXVCZzzSZqiFaWx
         dBpmYfBppks9vTB6XrW1a+B5YwnM78vAGzedgX3JfIG2dicAh/OxzoV8g8GE2vJ6U2mG
         5qugvTkcsbNa531+YMMzcv4V72prM81W8un0KH2fjK2W2wQocjbXocuRON92eCGfDa8R
         s2OTdooO1POGYCU41lY6yw4rqNSNJuNBLZvhjUdWqxAEpcIRG4WRGPSOWsud2E++U0nE
         F1Sw==
X-Forwarded-Encrypted: i=1; AKwUvBzLxEMrq9siW71mZ5ThxdxbbYwvkMHlfMmgYthygaKeiPwtKK8drqITDq6NKay1iCLYKbuXipqttMQU4+47sRewrhI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FE8EKRsz0aLuUg+7nCB1Wa2Rk9tpIpeuvKXhYaHI+IUKysFH3
	rYx+appU1WGjZnjaEEUqFzOiXHN+w29O0K3QO1lnyZR5h3T1V2k2W0dK
X-Gm-Gg: AYBFou2LuxtheoXec5tfeI5Q7gzu3m1E4FFxPli3cLnxCjktF6FdfYWDS+L4R4A7DzG
	/CwJOsjDl4dVOyld0HK01uvyd/7LvxLblkXUqwG4Sf+/2IxaleKLj6Rb6yYUrbD9ccyQiCLrLC/
	X1c0xaZTIFNGsPQqSDyC79R+mt4gLj190gA1Ugm/ObQWE1nM0ZwcT1kNXgEh4F2O9w/rgcaayrj
	kh7w7JjkjCUMSESfMOi2EwnNYCsL4mMnUinj7HTSJuMMGIFn7h2TeN2MyXfDynckxKs7lQ0AuW0
	W8S2M2z1EQ72K4KHjyan8uBhZvLIZ/8nm9iyxC/eYGE9lrTJb3x5vXDa0l+OgMuHzkL7OhFKGpT
	ZNgrHLURnodJCvbB+Mhb92Q7pFfQkapBBh2zR9Pf6oo+lsO+8US1xYV4HcOnjb8YcQWghMiOucp
	gsFOZMkSexxuYm/hP3WtXhcctGnJxQH37GCXsjDjj6zhvCheTj1CH3OexltBEbdKsvf9/DnODfj
	Rf+PGKO8VuLeX7M9Y73wk+My1DtbQYmFQNaByz9FTQhQKi1znKewiFtGYENiKpsVwl0tIsbqVT8
	8zD1LQ7idaNvlqVl4eMiL/d5whB5kbVPrUtHtxPur8+rJsj45OFjvXqZM1HNI/FIKD7j5UQxvk/
	Z/mIX+G6nYXLEfL9LTYdo+pmIA/cGpimbMpOu7peaamJ3ouA2fuzv7vA=
X-Received: by 2002:a17:90b:2751:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3ae8984ec60mr9411922a91.51.1793674985074;
        Mon, 02 Nov 2026 19:03:05 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb36468bfesm514332a12.11.2026.11.02.19.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 19:03:03 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 03:03:02 +0000
Message-Id: <DML8PRKSQ4ZX.2A8Q5SC26RO6Q@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix suspicious RCU usage for sleepable
 bpf_get_stack()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Feng Yang" <yangfeng59949@163.com>, <song@kernel.org>,
 <jolsa@kernel.org>, <ihor.solodrai@linux.dev>, <kpsingh@kernel.org>,
 <matt@bobrowski.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <emil@etsalapatis.com>, <rostedt@goodmis.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>
In-Reply-To: <20261102073714.1103088-1-yangfeng59949@163.com>
References: <20261102073714.1103088-1-yangfeng59949@163.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 11:37 PM Feng Yang <yangfeng59949@163.com> wrote:
> Route these paths to bpf_get_stack_sleepable() and mark the new protos
> might_sleep, since build_id_parse() may fault in file data for
> BPF_F_USER_STACK | BPF_F_USER_BUILD_ID.  Sleepable programs that call
> bpf_get_stack() from inside a bpf_rcu_read_lock() region are now rejected
> by the verifier, which is the correct behavior for a helper that can
> sleep.

That's a new feature. It's not a fix for the splat.
Andrii's point in v1 is about build IDs. That's a good reason for this
patch, but the splat needs Songsen's patch anyway:
https://lore.kernel.org/bpf/20261028121859.994-1-yangsongsen@insta360.com/

                                        Songsen's patch  this patch
  ------------------------------------  ---------------  -------------
  splat in sleepable progs              fixed            fixed
  splat in bpf_wq, task_work callbacks  fixed            still there
  build ID when the page is paged out   no               yes
  progs that load today                 all load         some rejected

Row 2: the callback is sleepable, but its prog is not.

  bpf_wq_work()                    rcu_read_lock_trace() only
    callback_fn()                  prog->sleepable == false
      bpf_get_task_stack()         may_fault == false
        __bpf_get_stack()          no rcu_read_lock()
          get_callchain_entry()    rcu_dereference(): splat

Row 4: sleepable fentry, lsm, iter, syscall and tracepoint progs that
call bpf_get_stack() under bpf_rcu_read_lock() or bpf_preempt_disable()
load fine today. With this patch the verifier rejects them.
It does so even when flags don't have BPF_F_USER_BUILD_ID.

Pls respin it as a feature, with a new subject and commit log
and a selftest.

pw-bot: cr
