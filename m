Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.38.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795103501;
	b=HlYuuUtfs5rpsNMvLxg+bNaK2bRIMEFBbgCjnRnO0P5+ZeNPXhJfJYOj0wNrsQrKzYuS
	 uzbQ1FtrhuvRagX6Z0tBqg3R/OYINzqNDvmVu21Ja2paEejAfbyQ27YmaJNLp3X/1ObAx
	 uTbEUentv6AQUJ1JJL8QVYq0yoLzxrL4KzSi8BP3ePtMP4Z0TUHQBqFrnZR915mFqAIcd
	 gDtJmT6Uca8weY6g38cBzxvqRAMqqYECUb7gUlNd1l/Dau587nj/+nksWQ2ZEpGL3c2I8
	 0UQpkw2YwNPAg5Gphu1cGlQSRqvuVdFyn5jxw2o4XeJzcaZdH0etZJ4+IRpmsgNivOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795103501;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aUQjaajJs+YI9KZ+2DHlE4rTbWxHRxMJr+lAxparxYg=;
	b=y03GBv4yiIdWFOHxMQgNnnOiUsfkGSlBXIazd2blsQN5ubK1ryleX5pgjPTlTb2vCV2V
	 VKFS1g78+paQS+5QyGI9InLsdxCtUXq3GVF88pG61bmIJACCLZ1ybAT7mSX3IdLFxzhJZ
	 lsgSYo1P4pVt7ZtyWuqpSj3buE2xKrxKZnx7G9F35cp2/pPniD5NLQagk5AMhyrjM+IqC
	 7FoiQEE42PjLfLFFaJv/6TZ58dp2UW14V/XTSp6aXS9KEUx2VOeQvQf6HhXcuGsBB2UmN
	 Rcv79QDcEEFQagjjA2Cd6oKWexW7NiHt63yPkFA75n0cOd1WxtnUPgbStvdzPC1tqqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=sipsolutions.net;
	spf=pass smtp.mailfrom=sipsolutions.net;
	dkim=pass header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=TH0TLrOk;
	arc=none smtp.remote-ip=168.119.38.16
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F7606A320;
	Thu, 19 Nov 2026 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=TH0TLrOk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=aUQjaajJs+YI9KZ+2DHlE4rTbWxHRxMJr+lAxparxYg=; t=1795103500; x=1796313100; 
	b=TH0TLrOkFB7TLIU5PGx5tt2lQ46TYV7eYfEgrMRUggJOCXHQvBuNjv2zfGd4LMKg1/3HPlGIW6P
	OyCsJplspG/MaW2GEFWWZMKecRG1F7mONFgq5OwoqAAaIjqj1A1TVXwSymYXWmikAmuVTppmSEVVw
	FOtylZvjbYpzna6J+xHx9CRQQXNSQiA9IFz2tmk6cDWrtGjamT3qgwhaKZrDpwqxzTSKOMr/HUlQr
	IewIGcxxp77I8qHVxJL/a/NoCSFkMHkNxkm1s8mpq3jo4OiljkqvZMiiWvUShw2tAwfvdLKYvpuBu
	1p1HDnD/KT29zKe4MlWzBNqUxUnvYmIIsK1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU4QC-00000004ZOV-1MaX;
	Thu, 19 Nov 2026 16:51:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH v8 0/4] tracing: improve symbolic printing
Date: Thu, 19 Nov 2026 16:48:40 +0100
Message-ID: <20261119155133.355849-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This new version just updates the samples to have the old
way (marking it as deprecated) and fully fleshes out the
sample for both new ways.

v2 was:
 - rebased on 6.9-rc1
 - always search for __print_sym() and get rid of the DYNPRINT flag
   and associated code; I think ideally we'll just remove the older
   __print_symbolic() entirely
 - use ':' as the separator instead of "//" since that makes searching
   for it much easier and it's still not a valid char in an identifier
 - fix RCU

v3:
 - fix #undef issues
 - fix drop_monitor default
 - rebase on linux-trace/for-next (there were no conflicts)
 - move net patches to 3/4
 - clarify symbol name matching logic (and remove ")" from it)

v4:
 - fix non-module build and possibly dynamic event handling

v5: (https://lore.kernel.org/all/20240614081956.19832-6-johannes@sipsolutions.net/)
 - fix build warning in non-module build

v6: (https://lore.kernel.org/linux-trace-kernel/20260921101538.97286-6-johannes@sipsolutions.net/)
 - rebase
 - fix nit from Paolo (I hope, I don't remember changing it
   but it looks fixed!)
 - fix crash due to wrong data placement

v7: (https://lore.kernel.org/lkml/20260922110955.363677-6-johannes@sipsolutions.net/)
 - update ovs selftest
 - don't ifdef drop_reason_lookup() prototype
 - fix section alignment

v8: (this version)
 - sample updates


To recap, it's annoying to have

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: 0x20000

and much nicer to see

 irq/65-iwlwifi:-401   [000]    22.790000: kfree_skb:  ...  reason: RX_DROP_MONITOR

but this doesn't work now because __print_symbolic() can only
deal with a hard-coded list (which is actually really big.)

So here's __print_sym() which doesn't build the list into the
kernel image, but creates it at runtime. For userspace, it
will look the same as __print_symbolic() (it literally shows
__print_symbolic() to userspace) so no changes are needed,
but the actual list of values exposed to userspace in there
is built dynamically. For SKB drop reasons, this then has all
the reasons known when userspace queries the trace format.



I guess patches 3/4 should go through net-next, so not sure
how to handle this patch series. Or perhaps, as this will likely
not cause conflicts (in fact I've been rebasing it for years now),
go through tracing anyway with an Ack from netdev? But I can
also just wait for the trace patch(es) to land and resubmit the
net patches after, seeing how even at v8 I didn't get an ACK
yet :)

Thanks,
johannes

