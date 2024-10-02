Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FA1D0DC1;
	Wed,  2 Oct 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882044; cv=none; b=sg59b2ZtLeD7PxRYmfciZBd1gVpPmGVprWXulIfhcW4hpu/bGWoYGdqqkFlzNKV+OnZZUP5FIKq1YE1956J46gKGJiFfLETNfUdivl3YAqenuCYu7yg7O6s2qB0weUBMbQZSYI3hjlSS1lYeLrxizRWVibBqhG6zVtm6CqGoA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882044; c=relaxed/simple;
	bh=kPv1uLe3yySjHfTgnB07/UgNSSkRM7obeMdDeQqouO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imgF9Z4DX0HZiH5NQvwdfC2dJdic7y/zXbH8erMc2oUnR2gfEL06kKPz+AU3adq9VPNPcPzrQlaihcilBuqkeyLemeXegdPMhqTq1NFO1YWpJ7lgwPZhIRPtiuhx0mRnsCntXv7WxFh5Ta49jdHCXnicL7A2Ge762sD4Bt8RwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDBEC4CEC2;
	Wed,  2 Oct 2024 15:14:02 +0000 (UTC)
Date: Wed, 2 Oct 2024 11:14:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: jeff.xie@linux.dev
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
Subject: Re: [PATCH v3] ftrace: Get the true parent ip for function tracer
Message-ID: <20241002111454.4ff64103@gandalf.local.home>
In-Reply-To: <d9b403220b1f7ebc90c76d6da31f25c9522a8ddb@linux.dev>
References: <20240910133620.19711-1-jeff.xie@linux.dev>
	<d9b403220b1f7ebc90c76d6da31f25c9522a8ddb@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Oct 2024 14:55:54 +0000
jeff.xie@linux.dev wrote:

> September 10, 2024 at 9:36 PM, "Jeff Xie" <jeff.xie@linux.dev> wrote:
> 
> Kindly ping...

Thanks for the reminder. It's in my queue so it should be picked up for 6.13.

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20240910133620.19711-1-jeff.xie@linux.dev/

-- Steve
