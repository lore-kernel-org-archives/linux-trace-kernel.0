Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C143ACA60;
	Mon, 21 Sep 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985748; cv=none; b=fFETb6aWvIE/bf+vae/Uq2O7Y1Df0z6rYE4wP8XnZuOFbtXlMMgX6yiFH5YfA9kW8BqLBCVIVgt7I4x0n3o4zkGwzIWQ3hDfXhDpJPRYMVTYInPSwGKSJI8aNkkS6Wlf2Z1i7zljr+2dN3LBsuh4DonKDHRL4VWcSSYkCiNqS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985748; c=relaxed/simple;
	bh=xEC6xBBqhq//B9rzrg+5avcdnnphrf5vLATyi2pduA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+EbL2TYbJPNln7r22sjiR2kJvp2pW3Cp3RcVkVAVVY+bD3YBWH5Wke/CiNpUb/tjc8uFw+bH5FrcuRwKVd9JHTe+TUnx5FbyCBM98zU/ZwVDBj6KwHoXX2d0Zmws7DSQZ7lRNdPaahb4kta+gG6f/uOsXlDBg2U/S/4ufORDXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=o6wK/eY+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="o6wK/eY+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=cwqAOlnhc+6HZ2eyKuzwZsSYpvxZrNYfCxWytEKGBYU=; t=1789985746; x=1791195346; 
	b=o6wK/eY+Z7oeXyS8B9rhpJAr+8yqlYzCuteM+ilYTcEn+y45xfE8GMwDoI4mYDWXfXh8na/w9LG
	zcZmfwjyh4G/wQiZ9tDoenpfb8gg0w23fiQFsRpjerCAn/e0J7m5J543ZuYx/XFpJ/co5qftfW/Qh
	5PVaKc5Vq0x+dhVyYwWL18222Nt7Ifi3ZptyD8ekJOcVaEsP28fPdvPozvKCcjRHFmEe193+8thXa
	VIslr1hOvMsYDJ70zECdd0B3aPsXd7EWZTVZhcazKZ0FvFeD4K8uT8JiWgwkoinIvo/meh1HuaTLm
	LzJlfOL786ERyMC+1FxM0swL94Wk0ZphBZlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x8b3l-00000005jvH-3hGw;
	Mon, 21 Sep 2026 12:15:42 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v6 0/4] tracing: improve symbolic printing
Date: Mon, 21 Sep 2026 12:06:31 +0200
Message-ID: <20260921101538.97286-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Alright, this took forever, it never quite made it to the top of
my list ... Two years ago Steven reported a crash in v5, and now
I finally really looked into it and realized it was because of
section placement.


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

v6: (this version)
 - rebase
 - fix nit from Paolo (I hope, I don't remember changing it
   but it looks fixed!)
 - fix crash due to wrong data placement


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
