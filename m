Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08A12883C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811414; cv=none; b=guB7qAL2Gc5ksziT5NmF9/MdgZbVMcighGjopTQhbTu2gy6ojMgslksyUYolj5KfRm0P1gRn7fJLXnHF94HyekABFALXj2mEDQYYvP2s0Q1K+zdAXQFTsOLqQ4gKGXwtaVgpU2ICxERdzBWcynNc9+qC3Z8ChHwpMGelMy5ii0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811414; c=relaxed/simple;
	bh=csE9+Fb1qbDL7EQ9gqnLFCsH8i1dvljsRV4NNfkRqIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOpob6omde0LMrE85m+ueBbT4pmx90nHOCLuc2R08oGkmtFqvn1JmG4Pbfmjjt49/UWw7l8OxTlFoiVhxo+wREv3zxzFH3HoLR5/ok1hmohDtbJV5qqBFjmqt0FllC618fZjHLkB0RUSXzRJpuA81yqM6DHoeIj/TAhOWLvJQfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBRou20e; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBRou20e"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso9104a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709811411; x=1710416211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csE9+Fb1qbDL7EQ9gqnLFCsH8i1dvljsRV4NNfkRqIA=;
        b=pBRou20eRvrRPp746txBjnKlQFWBt8vYvN75U4XCRO+Tci3eivtClA5fp6MSomAw4O
         LNrJ2+L/sTDgbsrbqMF6Fv5zE+QwiMH3TbxScQ1ULbn26pwHqCTdcYTYGPzI5ZVBo6e/
         obMMDCiXNtb9d1Xv4E1+2ppxBOLXFKHlksG1FmVSHZOJ5gSKQkUkIcb1708pdZ+UetnF
         JxmJjNsk6VcVrMySB9sHtPWczffiwzUXc9HTEWB1Ilzb2Yq17NR1JnhO4VD/grW/lKI/
         7pw1TOEjBHGNkbg0GjBUHyAMH/KQHeGXfKDYyVLR+PMepPCTBqhu4hEayxb+amQtwhRr
         s5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811411; x=1710416211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csE9+Fb1qbDL7EQ9gqnLFCsH8i1dvljsRV4NNfkRqIA=;
        b=s4L14Eu/pRPcaMYlNEcIJ0c1GT9yZ5tu0k9SBGP6Y3fh7NkWtbuO7GWOU7IcKRKn8Y
         DRtWUVxub0rEYagNkvnDd4JWcHMWDGJinBOlflDICeQWi8JVfo3l7wG2fenBCcHMYMpn
         Gwz6xgDJs3KvDPB37d2VfsjhOSf2Qma07uzK+ObiWvIAX9xeCwiauaCWQtUA7RNMjZst
         4l0+az81WIxAgYjiXK6g5qyqI74+6Ts+/JIHnBZDcLFYBbt4w/xKfDegrl2gxH2ohZry
         6yHOlwoC7jVibFc6AkaRePqlaX1MYrym0lZGtmBtlqt5/IPM/XW1/OTe74qSQKL0fuMx
         GXrA==
X-Forwarded-Encrypted: i=1; AJvYcCWmpRpQCXJh4QMZkQN9lNYaPH2Y0UT1l55TasbSxTRIqETiloNznQ/o5xQaVOS/TwUMT38MxCiNK4qdElzb4xshyfz7/bE58eF5dOeF0exBYxbT
X-Gm-Message-State: AOJu0YzJYmBnD6RhPdRRxiuTbx5Adz+kXzWgwl7dhBv0ADpDnl/Mr2NU
	YnFUuS5NqIuzKMVAQ1qKQhYZ8ENp/9weV8kJ8/i2GpmOViBUr1GGIT5/0XglGTeMnrCBPG1iIZG
	rqXoQsFZ41sJSsnkpN87hR0zdIRk3VCYaYIvV
X-Google-Smtp-Source: AGHT+IFN+ugPG1MFVDNGu8EIOU8XjifORKg5Yakb5vpTZ17CLf2qhGejlG3OgPc/1FIj1oKxaSdO9DDiVGzlPE1EaXA=
X-Received: by 2002:aa7:df92:0:b0:567:f511:3815 with SMTP id
 b18-20020aa7df92000000b00567f5113815mr149183edy.3.1709811411456; Thu, 07 Mar
 2024 03:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304092934.76698-1-kerneljasonxing@gmail.com> <20240304092934.76698-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240304092934.76698-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 12:36:40 +0100
Message-ID: <CANn89i+xg_rSeaVNo__FdZkV46_CEhM8c2Gpr+i-GsWnqatAiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: add tracing of skbaddr in
 tcp_event_skb class
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, rostedt@goodmis.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Use the existing parameter and print the address of skbaddr
> as other trace functions do.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
