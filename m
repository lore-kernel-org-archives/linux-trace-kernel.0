Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7F1922FA;
	Mon, 30 Sep 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710098; cv=none; b=WiwgvNalzemgdkp0wAM5qfOXwIeQnxOHhYmptOyYf5CfApY+YOXSZtT/bfLFXJtHZQIcurPE+2NUzwRVYjkhxpIthnHmyqkO2fBlK5DtizG3Ot8yO23bOhFOhR8ov6BlB8pq2xml3uDFH/z9hnYCBdnXHudvP6uaUujBdyQBlqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710098; c=relaxed/simple;
	bh=eQtbKlab/bjzIBfgSHVGCGy6nQGMVGQqzzDAVlBPocU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ldyms5V6F2PBOegiUNHLemV0DU5r1H6UE6Zj0vUiUigcLaEP+pxWg4tc7TapvbHP4sNyLGTRn6I3QcxhoxOgZQkz7rWICrRWho/Et3oBjr9xVEqUyFuzHybiF2rrFlw6guzNtCA4YoRF9xmJRSNKq6vqV3FNOS1USRsjQkKRSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz624xMO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz624xMO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C638CC4CEC7;
	Mon, 30 Sep 2024 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727710097;
	bh=eQtbKlab/bjzIBfgSHVGCGy6nQGMVGQqzzDAVlBPocU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pz624xMOZ6Oai8DI3Lo3SjH7OPg2F3Hb3nP2qGesJv6VO6eQHmGgiPMb2JWhn73Hr
	 4++YDlvTdlpAAKdhkwUqoJtHb6df6G7Mmas0PTT467m1zhfsGj9Oyxj6rcsi40TXO3
	 YMKhNH/XroAZsPSpgyiy9If1hOx6UB+P5+Ds3y0Bo2DkbVkkRmDDwtV9qBcqfPfJ7Z
	 44ECSWhEX9BtH+DS99WwKIgJGTRQQLodzuoOS0XhWXw+L0hbZcyde6J+4f0BoBhZ60
	 9+YadP4i3ajHMJdD/1DpApKBn6yS/P5f++OPXQ7mrYGsCO5Z22nQtvBOVZ7/0fm8/H
	 O4qsaGuA2RvQA==
Date: Tue, 1 Oct 2024 00:28:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-Id: <20241001002813.6012587b5e52737a576f1d0b@kernel.org>
In-Reply-To: <20240930100630.7894c442@gandalf.local.home>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
	<20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
	<f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
	<20240930100630.7894c442@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 10:06:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Sep 2024 09:33:42 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> 
> > > the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
> > > depending on it, the uprobe_events menu is hidden. I don't like this.  
> > 
> > This is somehow like the current status of CONFIG_KPROBES and
> > CONFIG_KPROBE_EVENTS.
> 
> The question is, can uprobes be used without uprobe_events? With the
> current BPF work that I haven't been following, it may be possible now.

uprobe_register/unregister APIs are exposed to the kernel modules,
since systemtap had been introduced this feature.

Thank you,

> 
> If uprobes can be used without uprobe events, like kprobes can be used
> without kprobe events, then I can see having uprobes as a separate config
> menu option. If not, then no, it shouldn't be.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
