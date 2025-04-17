Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E921C18C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Apr 2025 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873052; cv=none; b=XmhF89OLiD0oLHT4jw+/RsDA/4V+NXOk+g2MGxj0mN8kOvsdrVVR2g89Eu9Cix2VL8sD7YT7J4HVBPE0Gy+wpnilbsyLJ9um5VItrdkWi2+2LlChNccm9jFOXey3jYxm7SLHVfSVIHggtfg/z3ftoPZZXzLnQfPTk/GZFizC+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873052; c=relaxed/simple;
	bh=jjODyzoHgOaSkMOizAfMka0/yn10076bTRY95dAS8m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQ7eRruNsfSIiHPJ1k7N2MiAVM9txBcc/Ag8DI4I/V7fSA8kvoP4DZlTAbZtJlp+wIqkYEMGsqSipR22R7CVtTQ71G4NgIwAPrirBaFDblMUet0BUVC9nF3X5pnl50w9qKFk0BC5LnQHmZNTgzCgKkBO6jjm+Y2qR4JQ7rywyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcqLBxSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcqLBxSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744873049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjODyzoHgOaSkMOizAfMka0/yn10076bTRY95dAS8m8=;
	b=NcqLBxSgsicmKMUpmjdlDHIM6vhtiSlWWZKlcxU9QRHildA+z8tZUrFlXDjuDk9Meod/4B
	m3WBdJO0eL2iR4Oi2gAdwtV36qBRC61GbgtVax8CTdUnkOfb9LJH0Wyq6la27xni2AtEVP
	dpT+wB5Yt7XNcYTJ4baVpdB/kwFD760=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-kRaWhrhINLeEhbVZgcRFIQ-1; Thu, 17 Apr 2025 02:57:27 -0400
X-MC-Unique: kRaWhrhINLeEhbVZgcRFIQ-1
X-Mimecast-MFC-AGG-ID: kRaWhrhINLeEhbVZgcRFIQ_1744873046
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39c184b20a2so192158f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 23:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744873046; x=1745477846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjODyzoHgOaSkMOizAfMka0/yn10076bTRY95dAS8m8=;
        b=LIMFMlvFYEZmYU+U71zTTE6RPYSrNFw4Z30YClrBNuEW4ChPMnrWgJwEW8xYhCni44
         C3ko7olIlng7boW1XSG7g7IxSnLN9ft6o5Xe/tyxuXbNVuJnDrUtK8spPuLQThKXK4gA
         vTUsCHpdMF1XDX3+gZVaUV5cXacavxf0znmX3KKvSpftDJrSSZcppFi7pl3BMO6qPanX
         oIinYcE0Omjh8b0IYRDOgWCt51FpXWlRUXB/JhBZQClZTMqoTAatkPvJZWais0hkKnaf
         4okmOYlZ+PM1lSk6ZGQSo+4rvCSCpQm73FqE2OOxmBVf1qhSgyUWfPRBVXWfKpBDVxts
         JJdA==
X-Forwarded-Encrypted: i=1; AJvYcCUHwCyrh8fhEgQsrVRMpOKF2fB+nZZLXvseoytkur92M2FX7xsqdHG6Ohdm9G6rWpUN82je19f1Lo2GPa3qfMDG7u8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7UHv/UqizEIwwdB0w9fVRj6+eV2d0bR6wOaIHWr6bfZcWOmo
	793OgXZc8lzsnsTSnq8GXTSI0Rkh3bUXDaOx+B2IPXFY295/3S1VMgPrL+2+WYKYY3aWCTANi3A
	RFk7WaUDj6ZzfBZmFf+G4B3JduVJv/tlDZfHeA3h3EiW7U+lEHNsZtMHl56dDqXt/osWXEw==
X-Gm-Gg: ASbGncupQBfDkDkbjvvBsRnwbdg+zFOtplQlswZdCz2mSi2AS2LKvbe2z6OVlKdC19W
	JL+lwnBmAlbVmzGErgctomWk6wzoBOi2/jNCqAEBiopsdWOtH7wYyV9fxLJSjzD38bT1Y7dbTFv
	TFJS62Wj66zJEG5oH4OoDVrQvzDYCioXqXomNVpjMANqW6xF3HU1+TrY+gsqcHAOXQMP/yRnS/r
	QGwr90mTpBNEyCv6Lbu0eM3vwktuvmBLz7CaBYK9ejg39j8uBnihR+/BEaTxMfmiDemRMW6WoDI
	idQRAVRGhfutuQOHnxbdw4toppzUMrZYom7AbfGqXA==
X-Received: by 2002:a5d:598e:0:b0:39e:e557:7d9 with SMTP id ffacd0b85a97d-39ee5b12f6amr4246213f8f.5.1744873046356;
        Wed, 16 Apr 2025 23:57:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxeneD4PU1badohm8V9WmJtKj9YkZnOXQdqdLY0Y/Fs91DJ14HKRGByKHiwMz/4SXoc3HdGw==
X-Received: by 2002:a5d:598e:0:b0:39e:e557:7d9 with SMTP id ffacd0b85a97d-39ee5b12f6amr4246204f8f.5.1744873046049;
        Wed, 16 Apr 2025 23:57:26 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43ce3bsm19526728f8f.66.2025.04.16.23.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 23:57:25 -0700 (PDT)
Message-ID: <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
Date: Thu, 17 Apr 2025 08:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
To: Breno Leitao <leitao@debian.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, yonghong.song@linux.dev,
 song@kernel.org, kernel-team@meta.com
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D_lb9PqugjIV7ynlbc9HXM6HZGg5ygpAIgtenDiyTT8_1744873046
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/25 9:23 PM, Breno Leitao wrote:
> Add a lightweight tracepoint to monitor UDP send message operations,
> similar to the recently introduced tcp_sendmsg_locked() trace event in
> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> tcp_sendmsg_locked()")

Why is it needed? what would add on top of a plain perf probe, which
will be always available for such function with such argument, as the
function can't be inlined?

Thanks,

Paolo

