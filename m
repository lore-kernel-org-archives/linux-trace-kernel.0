Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A13CFF49;
	Thu, 21 May 2026 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365841; cv=none; b=RGoRoogdYf0BFFwHoA2UlVc7Zu+lt06+kbvjfVA/8024FU095Uw3Z2H4fHvqp3MPxjLRU/2fk7C7snRk10bWjkUY71ZVuzPERAqqpD2s5ODm00Gm1mJfbF6jUSjm3Rhn6KiRWY1Ve8zScNpOFXkI169tEKdg9Mp/Bj29fKWfPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365841; c=relaxed/simple;
	bh=KIYSXW/HGIbp3maUaMEKC7fs8Yo327cypr6G5j7TMbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2RE3px4/tnVymwUylBegJMp6NygZw28dQikLFVKhta3aNqzZyZfZ6AwCGzKlNHKrRue+qxIu+l/+e2gDCdGL0lsXx0XKQpVL99l4m7UINOmgj3KfUuTA7yl98Cor3miK7+eOHFDePXhxaQXETIzyHs2QEyFxlThuc9J8ssHZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zre44ijK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zre44ijK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786DE1F000E9;
	Thu, 21 May 2026 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779365840;
	bh=ad9/IJhp+aVWzac1dIeKK6QsLEf3fb1pbkzRYTvRAqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zre44ijK2cvQ/x/+aSjkLGuiPiGazx7tjd9SzCwnzvJcQQHB6Vq5M20es6NfzwEXd
	 Y4eLB9fuYpzVhc+0ecm0X0PEvMCJlyJJq7uTfn6Z0whHaeE8FKR1eSYuglfl7+3EPu
	 aSqqScjNbmDrpu+vxzIMCID9mPr10nE7p0uZCJnscUTyRkzBlgOKsfxGXYdzzGeOZI
	 4twSSOyQqDCeUB6hSAIA0n8VAV2FdKufOT7Wo9quFlKOSm8jUgRdAChEcmHMLOIf+a
	 B1DD2upD3/v8f9Sz2tNSPH+g2qCEmN4bsoWGqY79mVIgcvRf5P1Vu5JM/tccnVm4A+
	 CHAWYFiS/92Eg==
Date: Thu, 21 May 2026 08:17:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 00/10] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260521081740.31194131@gandalf.local.home>
In-Reply-To: <20260521171353.74e66d117b0809418c8822d4@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260521171353.74e66d117b0809418c8822d4@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 17:13:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Thanks for updating.
> 
> BTW, it seems Sashiko is stopping review this series. 
> https://sashiko.dev/#/patchset/20260520184938.749337513%40kernel.org
> 
> Not sure why.

Yeah, I noticed that too. And it never did your v19 either.

-- Steve
