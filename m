Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF51ABEA5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883202; cv=none; b=VETLenpEZ8/Kz/PDaQBx4OJxRYe+E9KcdVROTeH2HGm2iZOihQoZBY/cLyAmVLnofqDEeheNe7ikdwu0QHUrJrMGZHJ/UdNUtYlkJflNMErKKpT65Ia2LdDvAe1xk2vbe2R5WX2hSPkJeaPa2yEThlWuCAuMvBsW2X3UUkjQ4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883202; c=relaxed/simple;
	bh=B6rcI33jR0AkhpRZXIBj9cKrGXC+Z78I+ZFwTdFFfe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snOeQTU1epxlqeuOUUcJ33VytD7SiqPp4kH31jbfzuSHboWi1uTBifBeg6f4GMxz6pCZa5wqwKi9hYA35zlpmlWRnvDnIwh5mquuvODTkd6kUV36HUPDKMpq7CoPFObzgEhifYZU1txrDNeA59bK+VCUYXYnd9cvzBZbNPKmX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvFKvQ4L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvFKvQ4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739883199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsfKFHU32JDYtPZqdtJcI1xvfyN6A84vuhKqOKdqLYQ=;
	b=UvFKvQ4LHLLCElHoKdLgdpOssQb7hXS4FJvDe3yHwqNEuNk3HVgiLBzy6mPvHJokqL6F+n
	P42GARssA158FexocYWqgD5G3V+luNf7sPBXxc+YagRccECdjvcpYsYvN6Z28ViIIa7q9L
	IkqRM9pIBh22WAJZ8WUbm0rFqYklrnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-kE8HMHFBOOWdgiFYDrs6ow-1; Tue, 18 Feb 2025 07:53:18 -0500
X-MC-Unique: kE8HMHFBOOWdgiFYDrs6ow-1
X-Mimecast-MFC-AGG-ID: kE8HMHFBOOWdgiFYDrs6ow_1739883197
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f32ac838cso2739463f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 04:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883197; x=1740487997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsfKFHU32JDYtPZqdtJcI1xvfyN6A84vuhKqOKdqLYQ=;
        b=xUPU1b3rtcR9oxph+LWFK/GE9iZ29kI+vbtyMsFPZAJU8M5fz+f+E6hwBkuqmY7TNF
         YNZ9Yp3aarXQUZML8HozjPKG3Y7wk9AwYYCrnfbKruqdnrkcbw/gs+EB6CYMglY2i/Ij
         9ibaQCLBGVp7Of9S5YjL8q2ri6hI2Ay3gZeXZtCE8rjLo1FcleeQYxjk9tcHO4gONQeS
         l3ym/qvdp+Dk+h3M/QEDd61MIl833QgndasgDkf9RAFh+LXV/ni2wg6ZUp28T/ZDkk2n
         nkt504Bx926GwF0lkBEdb5jSdlISALcGpt7rlAAO13svFWXZTcJU1iLJV6+MZ2raxjRS
         0gNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd8YWkucQ4UcIXnOi6NGJgm6za0hxhNdDYX9zMvQjVd0HzCpYOdV7pSig1342v1DT5li8uaLzRKQeeyuHYKM/fjjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUe4IpnfSoi3cH3WXu9D2IRWV4IJI9sESXd60EzytHQijKXuRy
	sfANzA7a6xy9bC0ClNpCqQT4M0vQRZS52E9Tnji3pc0Z1mMplHU7l810LSK9d2CdAvMtva4jtsm
	mCSKXHqEV+FvzUQg1TqAVP7510cZTnQxiJunxGyouppF3CX37nOgO29Fz5Z+IeM7cl6ehig==
X-Gm-Gg: ASbGncubEA2oS4tHHYJ+Du8clHvNLtX8529cwysZWUX4nlODZ4LGMMb/y+rrMxsHDrP
	1KT/13fCEd7b2oR6zIVamFB2ha8Ryq5vHtbixH+9CpL4Uy/HlkSrT/G8YQ8JCbqzTAodAOegI2f
	TAOzDW7Oe9ZSuS1NW71xevREkJ6ixEKJ8/LwrVB+G5GuViFxtZm1rmvfg3c2lXVCGiUPi+1mnvZ
	FbkBSL7WGZV7rWQi8DHkPq/3AitUez7WnvLRX4odt7JYT4jlmkC2ZN/4Qini1fkmF/KMUqUL1ZP
	uRc1p/wkzS8YDDZeNXeCRlL8pHBH14lhV6s=
X-Received: by 2002:a5d:564d:0:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f33f28c73mr9321381f8f.18.1739883197496;
        Tue, 18 Feb 2025 04:53:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmuOBQoBPGkm0apcXujpsKNRJknLqhiWdlArj2xmAH10Rv73rZHl5OqE/4YMT5tnZCWC0Bzw==
X-Received: by 2002:a5d:564d:0:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f33f28c73mr9321354f8f.18.1739883197088;
        Tue, 18 Feb 2025 04:53:17 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm15132973f8f.32.2025.02.18.04.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 04:53:16 -0800 (PST)
Message-ID: <cc84f98f-d3d6-499e-9d2f-47eaeb56aad3@redhat.com>
Date: Tue, 18 Feb 2025 13:53:15 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Ahern <dsahern@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ndEsuOO9nA2EBuzReEipUXIxbsEyqfajkr28l5H5K7w_1739883197
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/14/25 6:07 PM, Breno Leitao wrote:
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
> 
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
> 
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
> 
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
> 
> 	rawtracepoint:tcp_cwnd_reduction_tp {
> 		....
> 	}
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> ---
> Changes in v2:
> - Close the parenthesis in a new line to honor the tcp.h format (Jakub).
> - Add the bpftrace example in the commit message (Jakub)
> - Link to v1: https://lore.kernel.org/r/20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org

For future similar situations, note that it's expected to carry-on the
tag already collected in the previous versions, since the delta is only
cosmetic.

No further actions required on your side.

Cheers,

Paolo

