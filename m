Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BA53978E;
	Tue, 22 Sep 2026 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075412; cv=none; b=T+EIBg8zIeQVM4zSlyVYRwKb6ZX6NMb/wcIYKIHSfbHSYVfJsxoMe/j54HGV/DmxDl5ml4dWLoNSdc387kPKb1Ev4XJLjGv42auFjyyzBz/SvK+w52aMOMi9wFdSKRBAI8vpUge/q9nEmx43NvjJUi1ZjfBTGsXtXGKm7pnF7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075412; c=relaxed/simple;
	bh=WkDJvOoP+CW0hWmbIbKnYDnpvPpJ0kxB6wzPOLTKlqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qx7gbBgn90IxwjLwW+MbA1Na9Rgbfdso+ZTphM6IXDtjPQK88VXtXqhYUpzKZUuP5yB3dLDYHdDNcYW+RUTQKcd2Kt/kv13SuhrAdg3Z1Ts+p3otAq4tOhvwSHofFnTNPNbqg8G//IJ4MOuKIXOmm2SlcMKlpYsn6kjGxbgJpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XY/KLR+E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XY/KLR+E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=3MvPJdWCA/rtkiEzKSTMgdlx6FiLQyGC5WVz8c6+6Y4=; t=1790075409; x=1791285009; 
	b=XY/KLR+E55afSSFH3G2bhpj7qSBj3WQv008AHl5jX8akuF+CZ/Shms56omljGIvdgrmyOtiycKY
	LiLQqzZTzWqIbE0jTFeCNAV6qJuUc0qVI97LWc3ojJLr7FrdorgmbGaYsrql1uGaPGHZtnoELxUHL
	fa+8BMCmhCj2dr68FaaR9qyj8Gq+seLilpQE1XxVbKLsUQgdQRs5/apAL2ywtHzR+4Kd1Zc2dZVAf
	p20phCpR2YTbHVGZnDlKhH5lnE2ycpAd11zzzGB03Pz0W44elYthK+ic4Y4RiwrUOD1lIyKdzRgLF
	BcAifmPidb24Ht7Oex2uQPhrT5xI0MW04RVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8yNr-00000006qo8-0PlI;
	Tue, 22 Sep 2026 13:09:59 +0200
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
Subject: [PATCH v7 0/4] tracing: improve symbolic printing
Date: Tue, 22 Sep 2026 13:08:39 +0200
Message-ID: <20260922110955.363677-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Resend with the selftests and the two sashiko findings.

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

v7: (this version)
 - update ovs selftest
 - don't ifdef drop_reason_lookup() prototype
 - fix section alignment


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
net patches after. Assuming this looks good at all :-)

Thanks,
johannes

