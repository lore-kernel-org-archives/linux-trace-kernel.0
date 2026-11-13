Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590551;
	b=q41XCIXd117nJYyIsHeNNV2Bzz2M4hAkgxADWSIXWfX17smxc2q6uVjChcmqFWcV4Azf
	 RAp7ioGgjGZf5b4B8D2T5yX0VTgY1CsdbctCrVyk7Bs2+Lm78RdmOaQxxx43SNYpHGmNV
	 NodAM2s7JGEhdbgDthj7fv7SJw9siTxAFo2XZKB9I5iBGKm+5YyoJob7LJFrC+chy0E7n
	 eee6UYqLKeF2/mz67d8vIBDiuV8ZhQyPlsT/v+yzmEV2f1KrpBiVfeiNoPQpufJWSJs4t
	 5ljqVhahOTBzEvviaa1t81whSU3hzGc8/nBS0T/IwMPBGJV59rADiIgjMJa+hy+v7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OXfE/1W5iYUB1NrGTtPkTsDeQzVdgtifzj98ImHtgPo=;
	b=jY2pcpUCvQfEbjd4sfSYCR4j1E27/OXsT2d1HjAZOIBICxTHAuHXBg9317DVR31V+d5D
	 IAgwsNqNptVJDXUkbyH2yeG5G8UmC1USUP2bxfTCo/sNJQn04jEdSiDg9oyJMtYdEVE02
	 D8RLO7S6EFcw5B4PLoB8bsc3JMWK9QVZw7WeQECMLEznfCgemlPJXzJWLKRVbkvXdqw8I
	 /b42yKw/n77zs/qeN2qJZ0N2GuvEcCe9KwsqsUDRIKPIkXQrtTrUTXW8jo8hwvoQt0Kos
	 IGVx2vk1YFtKnhJVInKtqNT6q+Xg05rKbUbsYs2YRmCbniQ7njjBVVD/bWpdUOL2sIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjxkZf+O;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672276074B31
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 672276074B31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fjxkZf+O
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3155753eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794590550; x=1795195350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OXfE/1W5iYUB1NrGTtPkTsDeQzVdgtifzj98ImHtgPo=;
        b=fjxkZf+OCvJgyRQFlINphS3GvpNklkEUcMMifyEbajyUYfgGR2pCfZgoTsPAe0hjAN
         opijHSp8A/8EAoZumHy2iy34a2kc9kVqiTkavKjQjeurqIehnM9CkOfx81Z8oR0yX5ul
         J9tpsR6m3FHT4a9p/xAt+ZRJcodC3CjeXxhpf9FCU48HlCxCPWQjC75knoVVqu2lFIcN
         nHSzSqeeHutQy5biOw2l6oclNIlpNzW/Xl9YJQzjU9ivLVJYXXUktQN+NseViVRMAX5J
         NZhkkF6lfJOMroSC3tEqiJyfGmbFOukuvKX4idxUk3fiKCZTP5Kb2PQA+EOwg831zczn
         WIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590550; x=1795195350;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OXfE/1W5iYUB1NrGTtPkTsDeQzVdgtifzj98ImHtgPo=;
        b=bmTBRZbfZPcUCxJyJScT9ns27jHxZehge+cbd3Rys/7BKAOSS26g2yC89ljfBhfeOm
         IUDnrJz0PJ/irZ7HeyQ9Sw++2HH8R1zz/a/r9Qqpgs2EwaG/H0RX72zbj6Tt6oYLvkxk
         SiY5QCOmx4vFNR7FfMrzLdug+v8qdOdkqNoez5tCzWPD94h/Bp77U2TXY+Hja/wWUsos
         GJSzhoD6Dv6IDsqU6IJmEAZzTHCuC+4iZTnXa8aFylgPjzbpdx91T5vka+PO/lk8giQq
         G7XLoJ74TsElQdQCS8RukGkUSGh0spN9CGpys4RfAr0D2q0ufmsdT9yQ7ygdH8DHGFFu
         Dbzg==
X-Forwarded-Encrypted: i=1; AL+hErFuICtjtKASOxWMLC1AnazfQZi58ZAvwVY/EEgVtSJin8N/Y23qbrBEN37TktA1LoCkuGOuuKTUoNUwz+75eSv5pgQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TPiJkNXEpSrcgF9F3Sk1rWQrxY12sJZXJvhIxeTjZ6icsf2xj
	2sFw6LO3asysyaldLdllutojpBSFAC+pSM9bcj/ZO2hmgJqaKo86VKu3
X-Gm-Gg: AYBFou1K5a/toz+6HeyPT7vWzQHyDB3Er1nJIJhIhpuhChaNB2sOpkmIrKiX5YtmAmM
	753DO+ctyGyWoWqbWbcT/Lf+TXEqbWQkztKDdAEI1JEved1PJAiBvMM518WgZUaCwa45TkEj1EH
	+MRphh1ZLU7pktsUNnQ0bLFEsHzKj71zbzJjmZfaFptE3Zn3KWMix7XnOje4MFzgf0QJZeERTK1
	vYKd8MqzZmlBKrIKAdxUS8jz1bUrRAaqXIJk2c2q5FoE+05V0nqPV60SznSE8vZOW8rrngbjBhs
	OkEVmg4qFq15fZWtjsGhIlTPUd3+UqiIWnOHqL/sNbAzfOazV+60gj2V/CPrmsTH3490C09cNsq
	pfG+FwQET7WOpF1zjwd8JKf7ViHmTht9cdB16Vbvrvn0YHcBNLF7RjhEePf/ubncfM2C3BrCOYg
	85gTCWa4iyNxCkYsMyqOsXdWff2d0Ffu9GLvVGfdv310asRwFAklP9t48RJKA8ILO0Wt5kIXiBs
	apiDQyB4tJ1H3MwCL7uVODyeTEaYZSzfdCvufQTN3Am0EV8XT6DZUZt+x9QjY5SFaOuAGAj
X-Received: by 2002:a05:693c:8105:b0:36a:54a0:6b4c with SMTP id 5a478bee46e88-3796721e0femr2979743eec.25.1794590550340;
        Fri, 13 Nov 2026 09:22:30 -0800 (PST)
Received: from [192.168.0.216] ([182.48.212.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm11744319eec.19.2026.11.13.09.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:22:30 -0800 (PST)
Message-ID: <2f9cd058-c2a2-4a7f-a755-a66653a8f659@gmail.com>
Date: Fri, 13 Nov 2026 22:52:25 +0530
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] openrisc: Add support for KProbes and Kretprobes
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
 naveen@kernel.org, davem@davemloft.net, pjw@kernel.org,
 wangruikang@iscas.ac.cn, namcao@linutronix.de, kees@kernel.org,
 linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-1-sahilcdq0@gmail.com>
 <undine-1794560694824423564-2986102e2a604795@undined.local>
Content-Language: en-US
From: Sahil <sahilcdq0@gmail.com>
In-Reply-To: <undine-1794560694824423564-2986102e2a604795@undined.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Masami,

On 11/13/26 2:34 PM, Masami Hiramatsu (Google) wrote:
> Hi Sahil,
> 
> Can you update the series according to the Sashiko's comment[1]?
> 
> [1] https://sashiko.dev/#/patchset/20261026201240.107462-3-sahilcdq0%40gmail.com

Sure, I'll make those changes along with the ones suggested by Stafford.

> Also, can you check your git email settings, so that the next
> version does *NOT* reply to the previous version.
> 
> This mail has
> 
>    Message-ID: <20261026201240.107462-1-sahilcdq0@gmail.com>
>    X-Mailer: git-send-email 2.55.0
>    In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
>    References: <20260930202744.50489-1-sahilcdq0@gmail.com>
> 
> But I can not find "20260930202744.50489-1-sahilcdq0@gmail.com" in
> the LKML archive.
> 
> Also "[PATCH v3 2/4] openrisc: Add KProbes" has
> 
>    Message-ID: <20261026201240.107462-3-sahilcdq0@gmail.com>
>    X-Mailer: git-send-email 2.55.0
>    In-Reply-To: <20260930202744.50489-1-sahilcdq0@gmail.com>
>    References: <20260930202744.50489-1-sahilcdq0@gmail.com>
> 
> This should be in reply to the cover mail
> "20261026201240.107462-1-sahilcdq0@gmail.com"

Oh, that's weird. Maybe I used the wrong message-id when setting "in-reply-to"
using git-send-email. I'll send the next series such that it doesn't reply to
the previous version.

> 
> Thank you,
Thanks,
Sahil
