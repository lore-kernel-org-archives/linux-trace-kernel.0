Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7C1EDA07;
	Mon, 24 Mar 2025 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850681; cv=none; b=Rjbkisapmgv4uX+NRcNnxr1awFI6Fvv0Kjmx5kt5Y4Zv36UEGDkGWQTCpNvooFrzGoZGh26Qfb8UHYdKkPE8Akrl+fa0MNP9hC5DiAofvq8q8T1tyg3ITIJAsgllwFO/Pca8q8Sz4/YK/8voOgKsLS2zODIzORK4hRFccDv742E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850681; c=relaxed/simple;
	bh=fhLh/A3Yd5/37SUdYsNbntjIunOJC8cH7XQHWbg5khI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2Q5CMRXlqbmnhLjBQLrHt3sJd6B9KFfD4SRgUegJjoX6by8VWYWpUZkL5RCXIq/zgT1mAM416VcaR+eTF1tgMY1Zg1yfK5P62XdyOKFgGYBK9gQeq+s+xDks+HV6y3Fu5sxgTlZlxs5Gt7QXlaykzZO/vb0KN35VxOrwXh6pBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061EC4CEDD;
	Mon, 24 Mar 2025 21:11:20 +0000 (UTC)
Date: Mon, 24 Mar 2025 17:12:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas Raillard <douglas.raillard@arm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix synth event printk format for str fields
Message-ID: <20250324171202.452e4195@gandalf.local.home>
In-Reply-To: <20250324094005.045cd547@gandalf.local.home>
References: <20250318180939.227696-1-douglas.raillard@arm.com>
	<20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
	<9d234136-05b9-46b6-849f-901df83bf54c@arm.com>
	<20250324144551.fc290f9cf9f57b3d2f205354@kernel.org>
	<a5af352b-9f0d-4280-8d7b-e72597e6265d@arm.com>
	<20250324094005.045cd547@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 09:40:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> So I did take this patch, but thinking about this more, I may remove it.
> 
> The __get_str() doesn't expect a string end. The parser should limit it, as
> the length of the string is saved in the ring buffer. Just like other trace
> events where dynamically size strings only use "%s" and __get_str().
> 
> I think the real fix is to replace the "%.*s" with "%s".

I just tested it out. Yep, it should just be "%s".

-- Steve
