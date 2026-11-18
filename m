Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010709;
	b=JxP8W6+nfLdpE9EhCDymTfnJU4XwlCLvSaAiGPSUIG6kUZMqYRFdRLJ1HddbTRMB12YS
	 Fd0Y9AAe5y9bQX4NmNu3ow7mSC5iuQPW8wDKpYGM8swHDmkgXyfaLm/HY97ixDF2fwrP7
	 urdoFWMY+xy1eCVmIzMcqxsoDu5f4+nwVCBmJvnKmeusawiLfOkvAcBAD/l/BMWxz9lwA
	 ln4flV8oymBqbi7ieiRH2IQK2ZGPLN2LrhuuKfX4uPz3P+OW3GbdjsUI/hHJbMnY6UeLy
	 cBj/mRq18mJOwxrowpXPAMO52kwx1XQNTTDg48zrRJ6c6Pqgv7xOewbSpWR+l+tFkDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010709;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=uaDb0isELu5PLoVKQvnokJQeD7Li1NqZKmsijy7vVTk=;
	b=hI/TEDS1h8ZLi0L77Z6zChG44eCGqVhJapyiZ21J1k3+zqiqqbx2LiBWDgeDqnBZe9th
	 x2f1GKCMF37RPUVkwmH+dpLkE/gtd5cArfxM9/OxlWpUKYQtnbZB0ImITkCElmdY9v6tD
	 ld57VpzaKC08mMVAonCebsEWwhyREPaoLduXroet33P1IX3qGZff5jSQVaWxB9UtjdTYo
	 cJCB5/gpD6wWXN09HkrYY/p4By+uBWFV7OeP5/SfYa+EqhN3QC1slixHNKSzLjZ1jtfc1
	 szZ53Z6XBZ1mvyUNYdu2pPJYZvTEyxZJe9HC9DxWxGMHBSmHihfQOySOU9DM1kEZqSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDvrB844;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19A606A32C;
	Wed, 18 Nov 2026 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDvrB844
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCDE1F000C4;
	Wed, 18 Nov 2026 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795010709;
	bh=uaDb0isELu5PLoVKQvnokJQeD7Li1NqZKmsijy7vVTk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QDvrB844BBPr7XtlzoGEhcoeWnNClJMe/gpwzT5ROskG7xbTZn2Y4krNleHTOvudS
	 ek9YIcSN3yWOkjtK67+z/DPTyBFhnf8rXbRasJjXuMgZ3HvAt7ZcgretsZarFbTgpB
	 /w7nGP/YCa0RxKPpa/P2MKxY0nRLjauZzkqGnS7fpCkgwaFxtHtP2z7l/5ARXrLvI0
	 Oi9BrwHhydcXUHyLq/X4pbf478XjWKwSlXx26lZcy/0keyDcKcgYquRjRF/Kzl3NsH
	 r5GA1MbOLwJ2CKgnXXlj5FZVOC386fbjZVE1qyzSm3Fl2X0v+k83ehbdegDRtbY/hH
	 l8U/NH2Bk7Oag==
From: Christian Brauner <brauner@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Chaosheng Qu <quchaosheng000406@163.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1793157924.328974.4869096@163.com>
References: <1793157924.328974.4869096@163.com>
Subject: Re: [PATCH v2] tracing: record jiffies in writeback events instead
 of computing age
Message-Id: <20261118-hochland-hockt-lidschatten-3b0491c4fbc5@brauner>
Date: Wed, 18 Nov 2026 15:05:04 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-04696

On Wed, 28 Oct 2026 11:25:24 +0800, Chaosheng Qu wrote:
> From 677560a14dae0d9581effc5cdb9375052902bb21 Mon Sep 17 00:00:00 2001
> From: Chaosheng Qu <quchaosheng000406@163.com>
> Date: Tue, 27 Oct 2026 14:28:09 +0800
> Subject: [PATCH] tracing: record jiffies in writeback events instead of
>  computing age
> 
> writeback_sb_inodes_requeue and writeback_single_inode_start/() compute
> the inode age with:
> 
> [...]

Applied to the vfs-7.5.writeback branch of the vfs/vfs.git tree.
Patches in the vfs-7.5.writeback branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.5.writeback

[1/1] tracing: record jiffies in writeback events instead of computing age
      https://git.kernel.org/vfs/vfs/c/ea7c5843e798

