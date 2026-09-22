Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1E5293E2;
	Tue, 22 Sep 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067821; cv=none; b=bIXa6W56jDqox8Oyi/j+kKBZIgax0yY/nFf/kkbuNLearOaagL6WbVtVImHR8wIN2FfvYcwfZ899MNoju5hGPcbIl/MjionbBt152SqbClWVEJ+P2YsAWWGSh7yL2VAjc3stXc+p7/Rs+BAPD6kwdE1SDpeaCeqI6+80izcw8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067821; c=relaxed/simple;
	bh=aYT+mVzhxslav4KMaqbakCWbpNHc8NrsSWL/s9tf+JM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNWSxzvArYBFjKS6+XJfeJkjaejBZYlQypcDgODb8R48DlnAN5mOj5dJNq891cwD8sKyfhgP3jfHf5hQHtXQsvsA9kN769c5ytoFBBuYI1XJnWpxe3WXwE3WpjkJwPqgau0YeU98IXfDEQ1OIhy1ODK4V+Nfa0G9hDx9DY9ZAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=T9lObZWE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="T9lObZWE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8uLeZHTq/tLb8yUdK4wo9lY1ExTBRxuRwq6XRjmQByg=;
	t=1790067819; x=1791277419; b=T9lObZWE4oX7ETYow+JmjrzX3X+PqmP5xwrbSuajrlWfqNz
	5U4IIOYt+zuy7m9lqg7EfL2TKv0tclzFC9nEoOgiEj7madjnuWqhiOGLWOy3ekpsXu+qVbn194eQg
	fI/gX7WRqHP+7cmm9/KvH+s8VI3wmHPQ/U9JJF1w6pZ/SnA6+LCLy+gxBT+9iagsxkcIS96wjhmgo
	rNzPJUNVAUfgLwduFnK7jKtecDGOqN+JfNklhYNS0Vi4Gw8F3qktymKwfvYBBR+MfmBLiWTSSN+6d
	w1g6GhQ4j6fkXvF7mP9hrfw00H0FtgpLWmehBJcDE1YKYGNuYo41b3MLttmHjpLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8wPO-00000006mxx-46Ou;
	Tue, 22 Sep 2026 11:03:27 +0200
Message-ID: <6c7170af0a7cbe62573fae461b94556f850318ee.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/4] net: dropreason: use new __print_sym() in tracing
From: Johannes Berg <johannes@sipsolutions.net>
To: Ilya Maximets <i.maximets@ovn.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Adrian Moreno	
 <amorenoz@redhat.com>, Antoine Tenart <atenart@kernel.org>
Date: Tue, 22 Sep 2026 11:03:26 +0200
In-Reply-To: <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org> (sfid-20260922_110114_464147_BE59E097)
References: <20260921101538.97286-6-johannes@sipsolutions.net>
	 <20260921101538.97286-9-johannes@sipsolutions.net>
	 <98b93c98-21ae-4248-a60a-9625a20508ad@kernel.org>
	 <7f557f5a-b21e-45cc-9d3a-cd4f8b5f799b@ovn.org>
	 <99e5f7c0d7debc8a59bac96e93f09600bf488ca8.camel@sipsolutions.net>
	 <4a0240a7b9ff87302620a95c73f4f265cd428618.camel@sipsolutions.net>
	 <dca799b4-23f5-4b6f-be73-bad5a3d88007@ovn.org>
	 (sfid-20260922_110114_464147_BE59E097)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2026-09-22 at 11:01 +0200, Ilya Maximets wrote:
>=20
> Matthieu mentioned we'll need CONFIG_TRACEPOINTS in the selftest config
> shard: tools/testing/selftests/net/openvswitch/config

Right, I was going to comment on that but then while I was writing and
testing all your emails came in and I forgot.

> Is that a new dependency or was it always there we just missed adding it
> to the config before?  (it's included in the common net config, so that
> is probably the reason why CI doesn't fail)

It can't really be new, perf to capture this was always used, I'm just
changing how the output is formatted.

Perhaps better to have that as a separate fix/cleanup?

johannes
