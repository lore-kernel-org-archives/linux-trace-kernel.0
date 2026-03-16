Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C432AAA3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683269; cv=none; b=pHXg0rBc9Jnl9F3Us38esGkswN618xqvuhACXb0oEe34vpPpdmQNojWyopL08zHVeeU+kS7PWounmSxXCHt6TFs1wGObm3svTCZQ7dkZTNMXDq+PeCHl9dsINsoBx1rQZJk5JJcDvV0OdpUcWsfgCtCTtemIHEucdM45FAl/fpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683269; c=relaxed/simple;
	bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WbzZeSxqrB80e2JzRZ3kLxlSyIJ+4fP82XLow7SC19/Cfsr2dFAaybY0ScDqCeD3yxiIyVp0uh38EHNbupU7V+QZ29v6Ntg66qn18+ZiblJ0sr+NprVSB6l/BK/P6GoyT4/a2UM3Fph5Dsf1xf+9zzZpB3TfZQ3svW2F5q9DpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=duj3MXX+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duj3MXX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773683267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
	b=duj3MXX+njab/VmBcvZw8iSHnEVw8y88Qw7L3ta4xobC5cVUB6q191Irw6IgQEuTHApnha
	nuFaS2q6BLjsPjdi2ZLDLAnTRhm6sJj+AnwxMp9f4c0NjjRdCl/3SblC2HzB+LC0qFVPXt
	H8r3v61AXtLQpEsrSuELzOJ5RMokaZY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-S8KX7i_UNKqY9v3h_K3hQw-1; Mon, 16 Mar 2026 13:47:45 -0400
X-MC-Unique: S8KX7i_UNKqY9v3h_K3hQw-1
X-Mimecast-MFC-AGG-ID: S8KX7i_UNKqY9v3h_K3hQw_1773683265
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43b3a0d25d8so1407450f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 10:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683264; x=1774288064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRVifA1HxZ+4XsSQaEhHgwmLLQrL+5Qxxw1GlMu4spw=;
        b=e8oo/WnsBNItDVis8WgNYSqMRUPWTPcO8avI21ek9+Lc/5e+tdA5Rg97vhllqTMU6T
         AALFmMM1mBDi3mco0uFTUoq4u8Nge5hrPmC7gGw9tYDKWHSXrye9IE3Oa4i59bIdzw9X
         aTW5c5WxDRWhY0th6Ak+ps3LxDbXoIVYVaqMMXk6zi4k2LSlB3wGTuZxS2G2g812LqXi
         WVss4svD1ZY5C9pFB2maS//kgNW6XlaHOoKqtt5TVo0fBEJQZeKXMHrbA2z/OAGGeJdh
         QAKKipMVpW1/FjW2sPnG6XhFYStS0d3bdMk3CwpeK/aUj0rxK2X8PSxxTec1EwSR5dVq
         oOeg==
X-Forwarded-Encrypted: i=1; AJvYcCXSl34rv+zjfNDgiswvO9V/Coa2+c4QwwsmYHFPLbag6XoIBB4bSKjKW0qEXWFQLoORdwDAYbSTQvUGIQ9wE3k0r0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaptu2mcDR+82YGokg/SP7bQgzimKdDpVCjfa6MrwjyhdKuaWP
	mxAD+6R+CLYy4HWkMHV3kKZFG+Ga1vXMjnlVyyl5FNjBFsADHyuxq605xAytgo6inridigPv+qD
	HGoYohLsCAcC5DabxMDf2iCFN61aUSon1S+RNerANEyVBnziqNJmqE6SLSrgiT13iuW67k507Bg
	==
X-Gm-Gg: ATEYQzxaHyrvZ0+9RzhzJtg2b/bDojRTWt3eaLCLdkOv9VHAEpKAmopHgnz3PDJbEEC
	zHg+os5zyRErXF6ojX5JguH9ZLZ6PjNTcnnfCHWp/omya8MaJ8AZcjyBq2IQRSqs9yZyVdvjGA6
	4ox5QVlBbbPfyfaIHDCCk13z7cqoUNtgbYDv9yfrcnx3K3seF86bZrUpt+xTPfedHz1uS5Laqb5
	gVQrTNLJ710oBlWveDJ2QCMKLhbKDOf126z/BN2U9nuxiJ2mFphCLMqGqaY4ELfcddNSpgWAlDE
	cwOS7m0nmMLM2OjfDJHe96kM3hCRiUcgVgEPiXZTQ2fGQqPoc04TM4yQ/NwSRvZ7dD7gIN+0AMF
	i01jrvAR7rDR+wnnVVO2giQNpNSWzqgxZEipg5zVmANY1Z89CsLto594=
X-Received: by 2002:a05:6000:616:b0:43b:4352:1bff with SMTP id ffacd0b85a97d-43b43521da3mr8977656f8f.43.1773683264538;
        Mon, 16 Mar 2026 10:47:44 -0700 (PDT)
X-Received: by 2002:a05:6000:616:b0:43b:4352:1bff with SMTP id ffacd0b85a97d-43b43521da3mr8977613f8f.43.1773683264127;
        Mon, 16 Mar 2026 10:47:44 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b41ff92a6sm17659188f8f.11.2026.03.16.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 10:47:43 -0700 (PDT)
Message-ID: <e93ce797-4153-4e6e-89b6-3839a0b8bca2@redhat.com>
Date: Mon, 16 Mar 2026 18:47:41 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting
 across ratio drift
To: Wesley Atwell <atwellwea@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, ncardwell@google.com, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, dsahern@kernel.org, horms@kernel.org,
 kuniyu@google.com, andrew+netdev@lunn.ch, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, skhan@linuxfoundation.org, corbet@lwn.net,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 0x7f454c46@gmail.com
References: <20260314201348.1786972-1-atwellwea@gmail.com>
 <b042de90-79e3-4976-9bbe-b6df3266caea@redhat.com>
 <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAN=sVvyNpkyok_bt8eQSmqc4f7g7QoZBUmRmNRLoFz1HasEzMA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tWQFB_BWm9EWjDo4ZS8SxkZUI2QvGFGZG4WHBRbhe4g_1773683265
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/16/26 6:29 PM, Wesley Atwell wrote:
> The strongest real anchor here is the already documented regression
> around sender-visible rwnd diverging from hard receive-memory backing,
> rather than a general receive-accounting cleanup.

I likely missed some of the prior discussion. Could you please share a
pointer/link to the mentioned regression report?

When posting on netdev please:
- use plaintext only messages
- avoid top-posting

Thanks,

Paolo

