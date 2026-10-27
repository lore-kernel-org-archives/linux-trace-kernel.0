Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793145309;
	b=1RQw9bBUc9P1Sx5DBl4ooRMGeMTpWP9Lc1HXCnJAZcOC1Au9x6JpaTfv2FGGaSnWrpnr
	 oVJH2bc3I5A1UerqoV1v9znYvt+az4dMrz7xbYRHmjrzH8sLDVa52n/FSzdPERZpUOumq
	 s96qfMskCauLFc+boC14pEymLwkQ06R/M+KbgiD0BSz201D7CHMJSOPyLjh42qaoaBz7H
	 CTVLM6OUgcoXoOMFkonEhyN30ETMRDw4k1n5k/TVj7bU7pkFD6rScmG4sTONEcFk1xEQT
	 5sztE9qcPJdBCYF5h+DXx4GN3RgY2z0nA6ESmcFE80VREcraNMJHn1Z4JUaNs1apnEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793145309;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Vj7zCX35JT4jkXfawg+CKE/Afwp2p1ZmDlu/iEQuq2Q=;
	b=tTc9PAT4uhAA1anCbfBbNXa7gMnZnjxEDotN3vmyPjLqpJIMon69fEceociDdjzxwsX/
	 kyIpz6I8RK9X7Aww05+O01yFSEwEU/CPNEpmR53+3Eqz0UNIKlMQ8t6q+4I5VSmhhySNn
	 S+wfhp8pEKxdHgeytSnXHsoQz8mLndr6NTOB1ySNeUuhzXOr360AFk6C4ONcOEQowZ1t3
	 DBQpGWHeT7GPYm+wU+f9hohbQo1xigzqukQTw24BcoWkow7AetA83H0Sy33t1X9LYpZay
	 zG+ccd9gw933NsQmiZgF5XszmjHWjyGEhakn7u+ZiX5ATvFNJFpuaQ+tFUlRdWpolmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1LLocZaI;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DE5606A31A;
	Tue, 27 Oct 2026 23:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38DE5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1LLocZaI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Vj7zCX35JT4jkXfawg+CKE/Afwp2p1ZmDlu/iEQuq2Q=; b=1LLocZaI1ii529MwHFQECtpVM7
	wXCRYCv6btan4eAXQ1pXZgAfJ1jUKnaSF0clE14mVbES2ixOadHYMEIEyi4DOxHkn0A0FkNibXRPc
	yJDJALYtVIx1AfQoed4ybWXVL4Z948P1hrMUGUyDDR4w5AO4s7ObNBIgf2hdfQiyHcYv4++J2NXGw
	2oowa2p4qHY45EthYqNPTxnv6KqTUFoQEejSBAndLL/unU1Akwk0pX7pkVbEBlEnEQqd5ygaI+AoI
	C4mso0DcRjPnJtus6dJb0M6XLgcAmkT4LnIb2QJRriKiY1QpaMrzNBzVqnyaRyez8O49jSJh8IBXN
	j33Q/VgA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLr0Q-00000005xuP-1dGN;
	Tue, 27 Oct 2026 23:55:02 +0000
Message-ID: <f34f14ca-21bf-4ae4-9e7b-da7f72d1b134@infradead.org>
Date: Tue, 27 Oct 2026 16:55:01 -0700
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
Subject: Re: [PATCH 1/2] mm/shmem: trace swapin results and order fallbacks
To: Xuewen Wang <wangxuewen@kylinos.cn>, hughd@google.com,
 baolin.wang@linux.alibaba.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
 <20261027094014.2432692-2-wangxuewen@kylinos.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261027094014.2432692-2-wangxuewen@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/27/26 2:40 AM, Xuewen Wang wrote:
> diff --git a/Documentation/trace/events-shmem.rst b/Documentation/trace/events-shmem.rst
> new file mode 100644
> index 000000000000..45da82761360
> --- /dev/null
> +++ b/Documentation/trace/events-shmem.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Tmpfs and shmem events
> +=====================

Underline is one character too short:

Documentation/trace/events-shmem.rst:4: WARNING: Title underline too short.

Tmpfs and shmem events
===================== [docutils]



-- 
~Randy

