Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7BA4E4C34;
	Mon, 28 Sep 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608882; cv=none; b=hQmlmwkVkOJRmkINdQWanpDDn18fH3bVilM8/7Jqmmrw+vXpZf00VNIaRWUHhavxKc04uaOxN1Pa4MEdJ9F25jPvmR//bAh7oaJ1aDRB857jl5ivHCEuugh4L/7aS2m1XoX4nctpdAVMmaTxeSI4Tu6IsCzPlDR8oBXeV9gMXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608882; c=relaxed/simple;
	bh=EUkPwheZZici6XP1YMdyTWtiJGhFGK9h8Ta1OYo0r3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3S9E19B/JlYJ/Q0hsuI2QfxvKw37YsjxgVn2db92rBAe24jqOrbsGsfjGNz7q+YNg+VuOvyXhB6MYPDx2Q9yNq1SC02e5XjIhuLJ2KDCoZk4LEbQsmFDRb8EgzXaxO0m5uKBcO8sSkcZx9VxMIYfVknXgfW4wTTAd0S0chd+7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TosNDjJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TosNDjJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74531F000FF;
	Mon, 28 Sep 2026 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790608880;
	bh=xX1y9CU8XcO6UQluKHgfAB+hJ4GpTOdTxbxNXrbBc/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TosNDjJe7Mh5QIx9zzwh4S/NJ+XQA2334s13t3CMbGWuyDracwfJmSMXFDzA/WzkS
	 iyz6dsH3o3sReCw/Amzsa15P0JSKoiysj8IpvqRygg1R6yiiMZm0fepWkjTFN3JCsC
	 AVR3Ft/FMpJh7Z19zGf+S9EAuwmBo2z5Z2TEK0Bu3wKyMx1Dnnm+yY4Bnow9jk1Ql/
	 95mAqQ5LD/mTUiEARnDmzm9wEubLri/RZskp5qHTqrslNNYCHHQALllofuCvFgVKCU
	 sXeOz1CyOOzJ2KEKd4SMbHwX2smDm0sc68SOMZxxBxoiV0MElHMAuXUfkzZJQv0wow
	 Eps4iwNrTt0aA==
Message-ID: <19e7671f-b233-4f7f-8ce8-83cfea294381@kernel.org>
Date: Mon, 28 Sep 2026 17:21:14 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
Content-Language: fr
To: Ilya Maximets <i.maximets@ovn.org>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 dev@openvswitch.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Adrian Moreno <amorenoz@redhat.com>, Antoine Tenart <atenart@kernel.org>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-9-johannes@sipsolutions.net>
 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
 <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
 <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net>
 <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ilya,

Sorry for the delay, I was travelling last week.

On 22/09/2026 11:01, Ilya Maximets wrote:

(...)

> Matthieu mentioned we'll need CONFIG_TRACEPOINTS in the selftest config
> shard: tools/testing/selftests/net/openvswitch/config
> 
> Is that a new dependency or was it always there we just missed adding it
> to the config before?

It is a new one, but it is enabled by default at least on x86_64.

> (it's included in the common net config, so that
> is probably the reason why CI doesn't fail)
Yes, but the Netdev CI is using the net (parent) config "by accident"
here: it is just an optimisation not to set-up a new runner -- including
a dedicated worktree, building a dedicated kernel, executing another VM,
etc. -- just for openvswitch tests taking 2 minutes.

If TRACEPOINTS is enabled by default, no need to add it to the config
file I suppose. But I didn't check if it was enabled on all
architectures supporting it.

Cheers,
Matt

