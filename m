Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645273;
	b=z+QK8IFN++/7DeZdQSk5JIxkrheO7HLPfoCxIb45hrQ+MvScKYngU23QIAXa6etuvEVC
	 VG5KImDYTBFcZPhsTJou8LueAjdhZVbZr3so92MgbpBcxm312i8hxs37MyLyMN51QawzZ
	 XGQPBhpSAtsVbdvGDGkkkgLzQcqj27RdncV2dJ4OLrtAO98lMCBdx+fi7Oy1Z5f+vCR56
	 p90UPZ0cSFT3DpmoOMvHjed3uaot0HkiUrTDAl0PvWhXAVABuK55iiirE7TkIzNpXrt1M
	 QiWnHDT8XiIY7cvMr09Q2LQJkRZ0sT8JZgWCgWA47Tj5kQG4iTGpwlKfa+MPM/tRoxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645273;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-Stat-Signature:
	 X-Spam-Status:X-Rspamd-Server:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=J93FtSMsAeP4Uw5SEY+87eyrVwvSQ29MiS0gXAjdpKQ=;
	b=UsQbbY4aDhOim3S8Wpbmx3DRlM23G1j87WXAFA4yvJiEyS3qo7+3qMdrFQg48+MpEu6m
	 7ONQ/YKR52uZVlW2tUVClohQWCyaOPsC0IKQXY09Zem8sfv8dKzNbhTvtWs2P+RCjLdTY
	 3mJZRGTfDZcAm48q1F8nZl12iP7L/mCEo+/3BbInBoTrs0F//8W5VhP411/A1Aa3rzQSN
	 DAkL5xV+ccs2tMAa6+oPjMm2DPSj05TX1b6Xhn5Iiwm4+dJ+7+w5dlyMGY/3fWTaUA2X+
	 c0mRVy/wHL407yp+0siQiVejKa18WKGPPQw3Fv09t2RX54r1VwsXmIhl8nbOFczQNug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=NNnB1r3O;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCF606A326;
	Mon,  2 Nov 2026 18:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DBCF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=NNnB1r3O
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A7A3E801EE;
	Mon,  2 Nov 2026 18:47:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id BA9A220029;
	Mon,  2 Nov 2026 18:47:48 +0000 (UTC)
Date: Mon, 2 Nov 2026 13:47:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Xiang Mei
 <xmei5@asu.edu>
Subject: Re: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
Message-ID: <20261102134747.033bf744@gandalf.local.home>
In-Reply-To: <CANgPUi1ev7Zb13Z4o=YdHY_JFf=7xXNHNVbR3KBDQ_p1rzUmZQ@mail.gmail.com>
References: <20261031175213.704021-1-bestswngs@gmail.com>
	<20261102111707.484df6f5@gandalf.local.home>
	<CANgPUi1ev7Zb13Z4o=YdHY_JFf=7xXNHNVbR3KBDQ_p1rzUmZQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BA9A220029
X-Stat-Signature: o134oqzux5pswg7bpcz66a8ksgz4grjh
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PfSENScwIdQ6BsNKsu0D5QfzY8CMtQ2c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=J93FtSMsAeP4Uw5SEY+87eyrVwvSQ29MiS0gXAjdpKQ=; b=NNnB1r3O+xmT83ClZIMVvrBeYePa6hWSLyVJ5T5VDGp8joRObP9YL3hHtJCGKCEXKgjpFfwIoDp+nZ+ndHiiLZ806TH0UF/+5QXYPBCZxSWtPCZmMdj1H92NWTaXVoS0eAa7LOSy29JkMKgup0rPNPoCpu+t93rAQzB1fzN4hfE=
X-HE-Tag: 1793645268-923158
X-HE-Meta: U2FsdGVkX198oJszNnjyYHs8EWAaqf00/djBxL6QeWaXi4N7qWtyKA6GNYw4/JZ2uAQWmFR4YSf0zLmjjzp+boxH4NuFjzg8WKw2/0E6TX+qui8I+bA8MrfXxY7Sd0PLMKPV1/4oafvUljoL7gg2iVZA6vZ0C49/nsE5qbdpBmgcsjb27k9L/jms8HurUyXqgMZNy/kY8IamLom5dRKDYy9gujZuM6R6dWpOKF7L1e4m9ADcFPi8K2NizkpNdr3YY0GzxkX+4AUyX/yFK4QmMW+qrMuhovMeFWCRdsDWvVTz1kJm4vf5n1slB7agzOFNGcgNwIl+wdkd2ExMzLVefJn0pUEZVSla

On Mon, 2 Nov 2026 10:31:54 -0800
Weiming Shi <bestswngs@gmail.com> wrote:

> Hi Steven,
> 
> Please disregard the v3 patch, as it was sent by mistake.
> 
> I am still working on a new patch. There are some issues that I am
> currently investigating, and I will send an updated version once they
> are resolved.
> 
> I apologize again for the confusion and for any inconvenience this may
> have caused.

Ah, no problem. I did see your reply but then saw this email again and
thought it was different. My mistake.

-- Steve
