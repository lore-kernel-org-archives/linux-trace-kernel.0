Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099A518128;
	Mon, 21 Sep 2026 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027993; cv=none; b=s78LAY9He7phtHxqknjMjLe4FpvC8wCzUNXxcP4aFLE89Ho24ZAZ9gmqmDB4RD74XSBKCtBzIHJpFBFtwmJF1TGptPR8eSFeXApKaJkj/k4U83VNJjg5wRXRrfjhGPsZP5krK5aSpuzavJFXZnyOahMTtu9F072cKxGoxzhh40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027993; c=relaxed/simple;
	bh=P7pJ5ArjsUD9qn9c1DuGNMBaaTalkAC5sKlwzEaj5mY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThIzGszs3N83ceDV6DQ20Zyx1W0soBpOEe3PSAT7esKNjOO5UbAeOkr3RKjk8GVeIMC2l+KQGLGLROy1kj2yhfPoaaf2/4YrtVwmS2DKTu5/zhRbc48x/P8HIMFYLbQ34cwl8nTSaqS7sNP82b7kmndDCB7wFUnbi9qjWeWI1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2QhAIGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2QhAIGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB871F000FF;
	Mon, 21 Sep 2026 21:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790027991;
	bh=KtfkV41wGWtsvVI6S5HWa0staeZRL5o4ro13Snucn3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H2QhAIGotWytKrhnBZIOgS73q3pGjoZQde0x72/y6IIVXpDBvZ2dQUsX8OgdsEPAl
	 rLCfwI4dvHxZuw+ESRVAs20R4VXGELDaTtylkv3zxtJpOLNNXCHA5hqV6yStmCWQrh
	 LqrCv4hi2vMAs3lVZyq8ft9Nzn6zdk2tI2d+lvqjNpSS0ruZDVQkdtymFxpR6csesr
	 MqxEHRgvZlKh61xhPTvIfQ5tCPg/LLua3NN7l+t4LciHlVdCd3lBSqers9pXfDzWW5
	 F68Ujrs3IZcmAMoHpAruMzDUZ1/H68katF7I++NbQGFMJICUSDRL8hWpaH9h6BTF2K
	 gqMXJvOyOVrLA==
Date: Mon, 21 Sep 2026 14:59:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v6 0/4] tracing: improve symbolic printing
Message-ID: <20260921145950.62c4a669@kernel.org>
In-Reply-To: <20260921101538.97286-6-johannes@sipsolutions.net>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 12:06:31 +0200 Johannes Berg wrote:
> Hi,
> 
> Alright, this took forever, it never quite made it to the top of
> my list ... Two years ago Steven reported a crash in v5, and now
> I finally really looked into it and realized it was because of
> section placement.

Breaks ovs test which tries to catch the drop reasons:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/833743/10-openvswitch-sh/stdout
