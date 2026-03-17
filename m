Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D1F3A8FE9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743689; cv=none; b=TOM18gWIoofGK/7NvzE/cyNU8Dt/C1R0eJmXRe0im33aQ/6LwWoxOX6ddBrdQuj3yUvJkkUkJbjG5prUpCMC2NMP9OOdS+QfamNEBQIEjbcTNXftKYIQrRpzg70kx0+6yYiABSWb7QSIsUMD2LC7UMpzzuyLh8Kgb9WY2xfksIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743689; c=relaxed/simple;
	bh=cOJ0pqLB05cW7l8D0d5y/xnlGOGTKB72z83QuCFoWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH2TPAeATayO8CUeJdbDnS4FTmqlAAaxbPyL1aKO7zd5huHG4j892jS2EUjx4+4W7JG0eNR3T5sVYtKTx8qRtj/EOmHm571NJNUJcwg1GYLtRtNWzA0x8HYT1zyZiUZO3L72j37HYWx2jVxtSX2MqPoMB6Tc1FCGCX6iCAUswdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SMzgLbpY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SMzgLbpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773743687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
	b=SMzgLbpYgqFjaZNVfrbSfUFEV/JDsNzeaAJjV3db+fqIQqrBwnCCi4xG8GXXP8LigYXma4
	SdhkuNUxDGi6WOYxlFy6T/UthhtEq854htQ10p7haIUh+D1wiIFwIwsXE+QBV1G+kumyOJ
	8m3CJG79Y3h4Yl6jKwKFmi0J3VXwkAM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-43HvASUUMh6aNz8yWq6JmA-1; Tue, 17 Mar 2026 06:34:44 -0400
X-MC-Unique: 43HvASUUMh6aNz8yWq6JmA-1
X-Mimecast-MFC-AGG-ID: 43HvASUUMh6aNz8yWq6JmA_1773743683
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43b42eee946so392769f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Mar 2026 03:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773743683; x=1774348483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny0IuTqhujPnnvktMKwVQKRIYww+FI37mlIAqoGoFS8=;
        b=eUznBCPK3T3VQvmDgXaYj8vOsUGCu6/oZDoNG9NcS27D/AVV3AjpQz2a2hFW5ObnPq
         LAu0f/aIDcPH6MuvQ3+W6QafO4//mTe35FFBE2K5eqA+dAgfJ/Qnt0+TAfPI3G5bPksM
         tWerrMOMxqnglDpEtviP5mBlqX/nPwwXzyIfL9MRqVvRLUTGshNv0dwZOs14ZuGiSRyP
         V5uVotEZNtIA9yCn+2iPJ5EhRF6CnABlvcSZH35IzSi1Wd/3u9LYvLxiaLj7kBCOpqUB
         V1ge7ZyMCb1LcvO6I7KMB9mZTmyeKxH2TUnywc1nQrb1hASGl5WQRsR4SBcTCoZadP/8
         PpHA==
X-Forwarded-Encrypted: i=1; AJvYcCV0/ChNkWlh923+r62wgKoJNCPdxVw8jH93QiqpAkE/n1ckdtKB9lA9gQK0YgZ/SzvqZatcM0X+LIFSazxPHag1ZmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAldjhJmWa5fiADe9zxreEKKdrKlncppsE2Q1VVgb3d5eyzoP+
	hGtK/OJoHCY4FlPp3MF0e5XYQ9/JJNrUnOTyxlzH8ymZ5HcM0twJ8Io0j3W2fREUp1oH9SNe0bN
	Syg+58BOxHh9Ev+NzkFYkZ4GSbHsavnSFrfiSlPyHhNrxiaYhMK0RYZ+IJmUj21QB5mzixFHl5w
	==
X-Gm-Gg: ATEYQzzose+gdiPeUSgohHDwaTuMd39cxObAfsamKNQoW5Xb07jQsselyROicjaApE5
	6p0PnERXtoequCA6h5CXNnbAKlQGXHLHwC4w4Q9LxyPLJfUKQD1t4ooVS85yw8u+8puP1mugjAI
	Kxqzdi8ZU6Cgynw1pGwr04Vv09O2wbb/+ip0LLxmVdXNYc9hhzC1kCNQ77HKYELIEwqv0pNg/T7
	PHR3pvqzUfuYSjjygnGweDLXqsoKhQOAl2H5CSJdclvIwrn2wDduRevIPXgqmP/TCPMo0vB5/e8
	C/Ft+fZPPMB2qlKdxhFlC44M8UYET67BSvKmLaffbAuZy4wG81HdgdUlummXAqtAttwa7tPCwVS
	NSqUtXuhGTtJGK1YcHByijzdk2KDyu9uORCvjuZ3I32pJiYiyxpRlk3s=
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655207f8f.3.1773743682879;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
X-Received: by 2002:a5d:5d06:0:b0:439:9812:35ea with SMTP id ffacd0b85a97d-43b498127a9mr5655135f8f.3.1773743682342;
        Tue, 17 Mar 2026 03:34:42 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3e9a4fcdsm22271699f8f.8.2026.03.17.03.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:34:41 -0700 (PDT)
Message-ID: <19078c41-5ee8-402a-9b60-fc4ab0fb8ece@redhat.com>
Date: Tue, 17 Mar 2026 11:34:34 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] net: Use trace_invoke_##name() at guarded
 tracepoint call sites
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Peter Zijlstra <peterz@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 dev@openvswitch.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-5-vineeth@bitbyteword.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260312150523.2054552-5-vineeth@bitbyteword.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h2rqbV1XgYU2hry3FpsWkUMLLSj39AJQfloah124U3o_1773743683
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/26 4:04 PM, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_invoke_foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_invoke_foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

Side question: which is the merge plan here? since this patch depends on
1/15 I guess it's via the trace tree, am I correct?

/P

