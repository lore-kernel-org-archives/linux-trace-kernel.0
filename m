Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE044C7556
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602494; cv=none; b=ZXWcw+zgQROZftEKzdwOUeCHrIV5Vq0qfB+kD7zf+YrNzuXPyGwXq4E8kNzWgNBn73OyadCzAQEUMrhA9yIGMJL6bIWzyUsWKnl81i2jv9Mn15TcdGlbH9PA+z9DFo0TojjjfJ+8rksNADgjy7Xj+JpTpJcE4Dqbj+lRtsU4o1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602494; c=relaxed/simple;
	bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UlmgyLCTzpF7OVHTEzYHCk4XYjHjs18+QnF+WwXWHPiTdJozlX+lJrxYgHzDxA4hRmiAcrlNFzd8cgAclf6q5lyLdElzwTnKKExnxNJldo6xo2k1ospcQiLeh9dvIiz3V147L3gJZEdHa/WtEVnqBNXxFVnM37FisqiLd7IZnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkFy3fbw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkFy3fbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790602491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
	b=DkFy3fbwq+zRzJ5p1rs1sLGXjR/g5O2zJB8Lej5uuB7cR+vJP3raia6Oyl/PJYTF8yBuaX
	83xeHqJNZSv2VS0AnW6VFLGyi/XGlrMcyytnLQTFVcxLSOTtzWLDyd3lT0XdKgDYH1Lvo8
	+7VhTEDLwY0BpHBb/f3/8vMwWlLDHJE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-4zvI0CDfMAG8tvbrQFbKeA-1; Mon, 28 Sep 2026 09:34:48 -0400
X-MC-Unique: 4zvI0CDfMAG8tvbrQFbKeA-1
X-Mimecast-MFC-AGG-ID: 4zvI0CDfMAG8tvbrQFbKeA_1790602487
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6b5c5f44so47398725e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 06:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602487; x=1791207287;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T0ZnyZmNOhJs9F62i79irExNdtrq2m1MmyPDQyS/l2I=;
        b=a2uiDfXHgXJN1OOLoxkh8bXYPAn2wXWlQ9TWCinZvwOFxBS4xD82szn7pI86xDDbCK
         2ywq8xdyCf27fvkE6uQuLobe7TRIH9YiUjzJGlFTyL+9hMpD5d8zvv/cdNHatDZ0Em36
         BU4Mu4uXbThNj4ygROmFxJ/BQHS70mKCryrGGwX6O9xh2jQ90n35arKixfpJrgoQWv39
         ueiZactU/C7XDo8XS0yzSbobRaDjr9LgFHQtXhkXFZjBM9Zq3gX/R1uZP7i2JGsX2fyx
         N8dHG3I7atN4LBJmeC9eJWZvr78AS7VECJqUhdv71Ou/GAi2wGqd931z7Rzkxhf9KGsZ
         XHrw==
X-Gm-Message-State: AFuF++lD80s0aYz2Z4Qr4hNqW11Q80DhI7Ey8QkjVga0sBIvc9LJTfV7
	AhzF+/HeNABcARfqebvveB/pkcgYrwoupJxcDWx4ZibVqqN57P8KkXxQYgUqtaKpdEvvt5YxvVi
	M2YQ0oxbP38aih4ApjWft4yiBdysM0owoOflVexwVdq5+CNEm4ZWcx0avfD5sBJJAmuQGPQsgbw
	==
X-Gm-Gg: AYBFou1Wb4ea4QUEFj88PgSqICdVr0wiDiM/AcSLhy/OlCkF8EK8ay/9udJ7KD3vsic
	HnV4Brs65S9FqEjqlPIWLHJXUeG8N99QczQQJw+ulsqGDbuoM6t5Ijr89AMoheNdLQM/IAt9yt1
	Xyb1q3HpmERx46T6QR2VvyY6Ov49AVCSiY0QdyL8s4+F5vfV7nKVFCIpYfob0wIHlrZuVvNHloU
	3SF2/huJXXVscAkzN0ycqLdU3SchahmmFFzXN+fBBk2ObfFIenVhHGfu0xNOOEGOdXq2aQSIQgI
	e46MA0vl9/IV1a2k5RYvKUAtmMw6Y8y9rkzDSWhMeqQm1YDObTwaLdeby7OzJ3KHWh+yxm/KzVs
	LqZybNQ+zQa84d8rIOh6qOENwvqy9ogM=
X-Received: by 2002:a05:600c:348a:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49fe7bbaf83mr214992595e9.23.1790602486837;
        Mon, 28 Sep 2026 06:34:46 -0700 (PDT)
X-Received: by 2002:a05:600c:348a:b0:49d:1840:4fd2 with SMTP id 5b1f17b1804b1-49fe7bbaf83mr214992045e9.23.1790602486412;
        Mon, 28 Sep 2026 06:34:46 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([24.151.142.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a001906c5esm144276535e9.12.2026.09.28.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:34:45 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  Steven Rostedt <rostedt@goodmis.org>,  Masami
 Hiramatsu <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Ilya Maximets <i.maximets@ovn.org>,
  Matthieu Baerts <matttbe@kernel.org>,  Eelco Chaudron
 <echaudro@redhat.com>,  dev@openvswitch.org,  Adrian Moreno
 <amorenoz@redhat.com>,  Antoine Tenart <atenart@kernel.org>,  Johannes
 Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v7 3/4] net: dropreason: use new __print_sym() in tracing
In-Reply-To: <20260922110955.363677-9-johannes@sipsolutions.net> (Johannes
	Berg's message of "Tue, 22 Sep 2026 13:08:42 +0200")
References: <20260922110955.363677-6-johannes@sipsolutions.net>
	<20260922110955.363677-9-johannes@sipsolutions.net>
Date: Mon, 28 Sep 2026 09:34:39 -0400
Message-ID: <f7t1pad8pow.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c2zF1hrh0XghFJliH8kvBwhyZGuI3xVbg4IHjXt2lDk_1790602487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The __print_symbolic() could only ever print the core
> drop reasons, since that's the way the infrastructure
> works. Now that we have __print_sym() with all the
> advantages mentioned in that commit, convert to that
> and get all the drop reasons from all subsystems. As
> we already have a list of them, that's really easy.
>
> This is a little bit of .text (~100 bytes in my build)
> and saves a lot of .data (~17k).
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v7: update the selftest accordingly

Sorry for the late reply - this series was caught in a Spam filter for
some reason.

> ---

[ ... ]

> diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> index a31f7fb6882d..9b8edfcd2d1a 100755
> --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> @@ -234,7 +234,7 @@ ovs_drop_reason_count()

For the OVS part (also nice to see the line count reduction) -

Reviewed-by: Aaron Conole <aconole@redhat.com>

