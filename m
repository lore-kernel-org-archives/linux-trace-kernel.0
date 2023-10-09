Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844DD38BC3
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpJZxarg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5D99
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696869642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YpXHXo6RBy8CnTiTObZdU28mMjUq9Z4XmoNn8CdwOg=;
	b=GpJZxarg63QqY3qaKr8AXD+yaJtM6ET7oaMghugAUUhIOueC/Ulejd2vSs/TfEsBPoAC2K
	c7EbvqCyypjqGHQTt8Q5qS5AatO0wqkJhrw3Oi9Vto7L2V/746pC79tUZMyTVNVcKp/v17
	IoCj6x6bgS+2MAVmBjkiWt/yqHdIlXk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-mRtlJ0SkM4CsvmgKHPJroQ-1; Mon, 09 Oct 2023 12:40:39 -0400
X-MC-Unique: mRtlJ0SkM4CsvmgKHPJroQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4067f186094so30413465e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Oct 2023 09:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696869638; x=1697474438;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+YpXHXo6RBy8CnTiTObZdU28mMjUq9Z4XmoNn8CdwOg=;
        b=cwP35tqbNkfEyUqDLclxHgzpSUidMPfG5CcmorVuUE4Yhj0YD8hi+bGH4OhmhYHvzK
         HxLAfj9Tnv0073Irj6lhYez8li2+PuBiJ2KO/0HCs38CISRdWSIcC5YEKsgeVXxvq9FQ
         WrdPMEW9VjjJQd4DBJpjmfO4/kJlhrc6joyQUCp0zh0zBoq16HH1azU7sXK2t0vjUqWx
         XDFNu8uMoT348EIM3HYLJVrpgp59cXcfelTwYLwDQ5tDtBG+M5vCo0LbSjskk/Oikmss
         uqgQcbGaxMOd+oaapUUfHGd7Tuy+yN3aPZ/yRw1T86WkgKD/PmzGL8piEjZimz6aynft
         kuoQ==
X-Gm-Message-State: AOJu0Yxhzarc62O5YKDUGgSnzKxlPynHqTShPYsJCBN30NB9D/OsclRf
	W+n7qveQX1Oyl7tuvsfBd2U9f3jEBswZQCR6TcwGmxUxQ3c4LXVA37n161PfNqdmoj9MFpvl5g4
	QEQyPRN/HpA0X0I9LZZyastuKrJFDqTDt
X-Received: by 2002:a05:600c:2949:b0:405:82c0:d9d9 with SMTP id n9-20020a05600c294900b0040582c0d9d9mr14896211wmd.41.1696869638576;
        Mon, 09 Oct 2023 09:40:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMgAs2OFs3TPKIXUcqwEYEgUj8NhgbOlPIyIMA79idAa9Hjf42+dP6kuPpgcF+X3v1F7p9tg==
X-Received: by 2002:a05:600c:2949:b0:405:82c0:d9d9 with SMTP id n9-20020a05600c294900b0040582c0d9d9mr14896162wmd.41.1696869638060;
        Mon, 09 Oct 2023 09:40:38 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b004030e8ff964sm14033430wmb.34.2023.10.09.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:40:37 -0700 (PDT)
Message-ID: <907b351fee183609891a4d0cfb0a79bad85577a0.camel@redhat.com>
Subject: Re: [RFC PATCH v2 14/20] x86/kvm: Make kvm_async_pf_enabled
 __ro_after_init
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 x86@kernel.org,  rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
 <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li
 <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Christoph
 Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Kees Cook
 <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, Ard
 Biesheuvel <ardb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Juerg
 Haefliger <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>,  "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>,  Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>,  "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>,  Juri Lelli <juri.lelli@redhat.com>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Yair Podemsky <ypodemsk@redhat.com>
Date: Mon, 09 Oct 2023 19:40:31 +0300
In-Reply-To: <20230720163056.2564824-15-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
	 <20230720163056.2564824-15-vschneid@redhat.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

У чт, 2023-07-20 у 17:30 +0100, Valentin Schneider пише:
> objtool now warns about it:
> 
>   vmlinux.o: warning: objtool: exc_page_fault+0x2a: Non __ro_after_init static key "kvm_async_pf_enabled" in .noinstr section
> 
> The key can only be enabled (and not disabled) in the __init function
> kvm_guest_init(), so mark it as __ro_after_init.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  arch/x86/kernel/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 1cceac5984daa..319460090a836 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -44,7 +44,7 @@
>  #include <asm/svm.h>
>  #include <asm/e820/api.h>
>  
> -DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
> +DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
>  
>  static int kvmapf = 1;
>  
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

