Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1434214F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911586; cv=none; b=cP6vNLOKdpliwrlRpYG44knitQXlXhyQeV7GpHVpxhlHe2rJFb7JVrS6Kk7wuBu20DJuunMp2vqmGqU4k5YYPficNXOUqboP3waPT6l/w+N8NRbshMbd6osdDr8wyUo5ExZTskabzM/9aiFa1juDsSMgvnRcFjd0XfJdNv5bb8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911586; c=relaxed/simple;
	bh=6fzFmvYYmy0FD/zsZjCIHvVy5pIl85gYKYFQYc5ntms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c0Uf0jv+ZtmGIXZIkuQWqOAL0+GHv+sbhM9cDZzSKUCSS3r4YhzBz1JF7LzrcyQXIzfqcuiKJD5TxCDNvHo/isBbfcZVesknUFyXJCY8zSCMCV4u3NwwhTnwReOtAh5wAwd7FjZAI8YHQd++OzUxVN17zJhhNL7PVQWoNNZrndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLW/68ZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLW/68ZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761911581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTUIS93GUZsQyg4tbyddEkDWsI2/kBv/P3HZONFfij8=;
	b=VLW/68ZHSgBq5lCtIBt6zBfYUUL9IMbTYLjZAqwK/FhqjF+QAXx3GTgJuMBL3GSVIzTNtD
	LkNkGQjSvlhnngMQwMoTJIMtampraNBpsyA+MGl4E7l8zOtU4XE6QYh/GSciXnW1xubfiQ
	5jnxJTDgQ9z0DxI0INAjX7EOwrYO8QY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-DxmgLJEtOSWG_eIEHL8IsQ-1; Fri, 31 Oct 2025 07:53:00 -0400
X-MC-Unique: DxmgLJEtOSWG_eIEHL8IsQ-1
X-Mimecast-MFC-AGG-ID: DxmgLJEtOSWG_eIEHL8IsQ_1761911579
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-427015f62a7so1711860f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911579; x=1762516379;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTUIS93GUZsQyg4tbyddEkDWsI2/kBv/P3HZONFfij8=;
        b=J1jucHqPvLvPV/kEgMrTlJs1wWdLw8heSXjLBnfcT1s8eIorGzRbKHN7C2AfqtgVr0
         dkSKdKnJ8FKvPM2ViAS2AC6UnSz8mCSVKbc6AJArWk8ekjq9z9ZcSH11k3rnfJoPofYH
         irlDiKGZTy06L/sl8HYL6/UErCR3Htv/AWhaY4WFEml5Yt7+6U2FlNBMv4mgz5MuXcUr
         +k58WLvaRZyH8V51rVHSF6rV2iMHLUwUbgaFNu2QZv9xB6r9PTN+RBTpUdY61ea5XBSf
         uCt88eApwE1nETpS+QrkDbuz3dTnZakSh1mNUeda2kolpRg9CvkDrJ5E1sX9mEJf6r90
         C62Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqnAbU5WkHyA4kumVL8LOL/dKt+73PeDJNr5hFURbyNZGkOt9dbFR2E66A9mCf1BP+OwLg7WsOcApIatIWLuGjgV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI04qepWZXmHCExKUL4UOmgv4EfddKkG98OqHCCvkNgHIECugx
	gzlz4JrZZUD18jnInqAHQM+RqsLtrCA8RWUzoFrE/29bhD20oLV46gUBHi/nlnDqU5AVJOi9tQX
	aZ3vBqPgsstTIxq6/WoHnAk/qJy5+VRUwldGiTm2UKZmV8soWmq/LJm2eakqBmHjdAuD5ti1Aog
	==
X-Gm-Gg: ASbGncvpPJDsLUE6KU7jIoP+ryok69Kiwrv22uc98VHbQhI/6umj9FmZztBTpIY+ESg
	7F/fTuaYUbkB2D0W04keUIBunLgOQDO3zA2ZjWZC5fuz0z8W+iuiF6/+nES0h2Pr9Z3k+6QVh6s
	CO2CzMjiHJGK91egV81znUcodjN9UpxA7eQQbFTjDXw1FUQXHUf7Lp3QctRVTybfgmtBsRkjcxt
	pPfAt3w8rEHObAArCG8nOD5mHc3ol2kgEkkoAkM4rLLMmRRBqoqP0+c6Y+NLiMaPKoYiX/NIUsn
	+ENHldq87uF13Yqh1pAmWmY3oTsBRNKr1g+L72oqx462+JXZ6jSS8+Qyo0lBoisxnFM9Pc+/1XR
	wgnkD46CfUQVk93eiWPxKZSJVUT71a5BFVfnmah2SuiWMKpCLRTWmCcYZXcD4
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr2912820f8f.10.1761911579322;
        Fri, 31 Oct 2025 04:52:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1wuetlLZ34asXy13r1bfmujThSOSUu3cZmMHhgfxqrER8G1YsbbHDsXHGv7ziQ36i83pqkg==
X-Received: by 2002:a5d:5888:0:b0:3e9:3b91:e846 with SMTP id ffacd0b85a97d-429bd676a88mr2912761f8f.10.1761911578857;
        Fri, 31 Oct 2025 04:52:58 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1142e7dsm3186896f8f.17.2025.10.31.04.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:52:58 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg
 Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Clark
 Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v6 06/29] static_call: Add read-only-after-init static
 calls
In-Reply-To: <20251030112251.5afcf9ed@mordecai>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-7-vschneid@redhat.com>
 <20251030112251.5afcf9ed@mordecai>
Date: Fri, 31 Oct 2025 12:52:56 +0100
Message-ID: <xhsmhqzujp9t3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bo9iXusR0jNdMKMOMCS3omOoXJ0wnThbmAxQjnrrZ1w_1761911579
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 30/10/25 11:25, Petr Tesarik wrote:
> On Fri, 10 Oct 2025 17:38:16 +0200
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>
>> Deferring a code patching IPI is unsafe if the patched code is in a
>> noinstr region.  In that case the text poke code must trigger an
>> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
>> CPU running in userspace.
>>
>> If a noinstr static call only needs to be patched during boot, its key
>> can be made ro-after-init to ensure it will never be patched at runtime.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> ---
>>  include/linux/static_call.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
>> index 78a77a4ae0ea8..ea6ca57e2a829 100644
>> --- a/include/linux/static_call.h
>> +++ b/include/linux/static_call.h
>> @@ -192,6 +192,14 @@ extern long __static_call_return0(void);
>>      };								\
>>      ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>>
>> +#define DEFINE_STATIC_CALL_RO(name, _func)				\
>> +	DECLARE_STATIC_CALL(name, _func);				\
>> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
>> +		.func = _func,						\
>> +		.type = 1,						\
>> +	};								\
>> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
>> +
>>  #define DEFINE_STATIC_CALL_NULL(name, _func)				\
>>      DECLARE_STATIC_CALL(name, _func);				\
>>      struct static_call_key STATIC_CALL_KEY(name) = {		\
>> @@ -200,6 +208,14 @@ extern long __static_call_return0(void);
>>      };								\
>>      ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>>
>> +#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
>> +	DECLARE_STATIC_CALL(name, _func);				\
>> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
>> +		.func = NULL,						\
>> +		.type = 1,						\
>> +	};								\
>> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
>> +
>
> I think it would be a good idea to add a comment describing when these
> macros are supposed to be used, similar to the explanation you wrote for
> the _NOINSTR variants. Just to provide a clue for people adding a new
> static key in the future, because the commit message may become a bit
> hard to find if there are a few cleanup patches on top.
>

I was about to write such a comment but I had another take; The _NOINSTR
static key helpers are special and only relevant to IPI deferral; whereas
the _RO helpers actually change the backing storage for the keys and as a
bonus are used by the IPI deferral instrumentation.

IMO it's the same here for the static calls, it makes sense to mark the
relevant ones as _RO regardless of IPI deferral.

I could however add a comment to ANNOTATE_NOINSTR_ALLOWED() itself,
something like:

```
/*
 * This is used to tell objtool that a given static key is safe to be used
 * within .noinstr code, and it doesn't need to generate a warning about it.
 *
 * For more information, see tools/objtool/Documentation/objtool.txt,
 * "non-RO static key usage in noinstr code"
 */
#define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
```

> Just my two cents,
> Petr T

