Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5886F2701DF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049336; cv=none; b=LLe4UknWIviXrSWu2qivWlzgHXq/tjF91VLTw/6mgiN5H19Ak7ITgn5d1t1hyAQJLmsrXDN0NiQRx21g3W2qRVetQDVAUNhzTY8INt8DlW+pW2/Qu6eGjOoBN3RhOxwYOU1kXAVyNiSF7MnuyscugZZLt/n6IaYGTFRn6wahWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049336; c=relaxed/simple;
	bh=bbp563xB+k02ZQyw0bOuD8J55G2HzTY7zLjAKvmY3ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a0j4Yo/XrCV8nmuoGA0AVdzZCv9dGkZK0/B+1JvbBsM17kQ33+ONikI5DqdZWhy0b3+ohwzRggtl57lmqq26Phkt6n4OOR6tnvaT7LKReMUFOje6Pw5blnmNFUE4/j9M6vD0a3ux4Exusjyr+6oNmtNP022f7cuDJZNx5TX8ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=gGBkfdTM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="gGBkfdTM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so931256766b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752049333; x=1752654133; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVNmahcL9ERzknhNwHAorX1ie7KJoJM18axXvqg5HA=;
        b=gGBkfdTM4AeM2aZi4PBrRYndhStsYrP/wjLmuon0igU8CWab+/NkkGnLSml3uVOR+K
         eqU6nJrvT5ITr4zgI2mHvZllvH2YPAHB8i8gVuIr/xZ5oMkwayw/kjsL52NmD9jlodEi
         btCVpPJexDd4/EQwDUcJJD8/EWEtx6yLRS/wz79QyWNzn1d1B5DtbI3OFBdOqHOlnd0h
         bcAioSFf9k5iEwhoobtiy7dk2CC+GHfvozOc4uFhJOVQK6MRnrrWTyW2Eg52Ajn33DjD
         DFLBqtj4ITIfaxQz3yBbA5Y48IPv2kpyPFpinFPltHQ0uEVDV/Bwnk1hhcAmaA6ghwUh
         cP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049333; x=1752654133;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFVNmahcL9ERzknhNwHAorX1ie7KJoJM18axXvqg5HA=;
        b=YrB2H1UespRZ0JwbP2WjC3+r4HixJBVZjaKNeE+Ytpy8v0vepAVXn9tb/TwbiUpeRi
         hyWscGBzIoRubmoeePZ/YjYOpksnVk8HD88eN1tqwCHxxGiYMqVYGzU76RLldVLa0CuX
         K8bdME8Sa+a0vBY8l2zELp0ieCHLkUcwcb3BR0MBoDW0xpKSHZ2skSVW0iV+/jnextv9
         zPd+duvRc4EM34m3oVQwIeoc9I5iXKePl8xtpHV0PUpEaZcy6LW6ib3SteWDz6ikbzQu
         AFrLlCEwk/AXlCmf0VmxXuSNnc8mfIrQXnGmutVYvKAd2IerYhgMLqILrYLTsLX2K+Lz
         XXXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZXQ7rdHf5qBn9Llw/+6tA+t8oaFN7XsZGz9gB4UU2byHD21M3Kc0ELaqqKkKIHoTrKEfWcHw0ZIjmKbAA1XqRx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+OYb77tOb0ngdh85qaxSsa1g+W8LPoG0f738HjTfAcOrLh4o
	JEQ+lcFdiD7umskGq90AXH6CKUzO83UqAIz2dnalXLVFCpdltF6V0vfGrqm0/l6nAC4=
X-Gm-Gg: ASbGncsmek30goDM0LpXpVH3Toyt+64n0Dmqw01RQ+erZIiuSKVb9AnuzevbHNFFhUa
	av94kIAFVIQOz06hNNpk3np98xfp/AQrCLyx42klNrZVdTeOCkiWp0g91prVMvqSjrX1uVPOE7m
	zhhXzU2lX3t6gO1C6EhEZFoNb5mSggwAg4ZMDA8v438DzqPpadqK6YWwZVPFjh60YWt/vDH0pmp
	ydJCQts4PdDVyEhC9DxnpuV2Vc/AnU2dB0Hr9Ka9kYqzPA+623SSXMbBcTaHaC77LK+UPPAzpyr
	IWdCYk4NZH36/iVpdPbEiuV+d90/c/Brk1ZJnwsAytyNOKaCNKfiNJQ=
X-Google-Smtp-Source: AGHT+IHhjLw7axM+sfg+4JbrvZ5uzjMQFSsgDBtJdAVL88Qnq4BGK12a+lUwgHht3jMZ3xAMt8/spQ==
X-Received: by 2002:a17:906:c116:b0:ade:450a:695a with SMTP id a640c23a62f3a-ae6cfbea8f3mr137410866b.61.1752049331750;
        Wed, 09 Jul 2025 01:22:11 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1f8856sm8372942a12.56.2025.07.09.01.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:22:11 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tao Chen <chen.dylane@linux.dev>
Cc: daniel@iogearbox.net,  razor@blackwall.org,  andrew+netdev@lunn.ch,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  ast@kernel.org,  andrii@kernel.org,
  martin.lau@linux.dev,  eddyz87@gmail.com,  song@kernel.org,
  yonghong.song@linux.dev,  john.fastabend@gmail.com,  kpsingh@kernel.org,
  sdf@fomichev.me,  haoluo@google.com,  jolsa@kernel.org,
  mattbobrowski@google.com,  rostedt@goodmis.org,  mhiramat@kernel.org,
  mathieu.desnoyers@efficios.com,  horms@kernel.org,  willemb@google.com,
  pablo@netfilter.org,  kadlec@netfilter.org,  hawk@kernel.org,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH bpf-next v3 0/7] Add attach_type in bpf_link
In-Reply-To: <20250709030802.850175-1-chen.dylane@linux.dev> (Tao Chen's
	message of "Wed, 9 Jul 2025 11:07:55 +0800")
References: <20250709030802.850175-1-chen.dylane@linux.dev>
Date: Wed, 09 Jul 2025 10:22:09 +0200
Message-ID: <87zfddepu6.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jul 09, 2025 at 11:07 AM +08, Tao Chen wrote:
> Andrii suggested moving the attach_type into bpf_link, the previous discussion
> is as follows:
> https://lore.kernel.org/bpf/CAEf4BzY7TZRjxpCJM-+LYgEqe23YFj5Uv3isb7gat2-HU4OSng@mail.gmail.com
>
> patch1 add attach_type in bpf_link, and pass it to bpf_link_init, which
> will init the attach_type field.
>
> patch2-7 remove the attach_type in struct bpf_xx_link, update the info
> with bpf_link attach_type.
>
> There are some functions finally call bpf_link_init but do not have bpf_attr
> from user or do not need to init attach_type from user like bpf_raw_tracepoint_open,
> now use prog->expected_attach_type to init attach_type.
>
> bpf_struct_ops_map_update_elem
> bpf_raw_tracepoint_open
> bpf_struct_ops_test_run
>
> Feedback of any kind is welcome, thanks.
>
> Tao Chen (7):
>   bpf: Add attach_type in bpf_link
>   bpf: Remove attach_type in bpf_cgroup_link
>   bpf: Remove attach_type in sockmap_link
>   bpf: Remove location field in tcx_link
>   bpf: Remove attach_type in bpf_netns_link
>   bpf: Remove attach_type in bpf_tracing_link
>   netkit: Remove location field in netkit_link

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
