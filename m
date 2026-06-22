Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208063314B7;
	Mon, 22 Jun 2026 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141717; cv=none; b=OBVnOUlVp+dYgDGC1dHTxWt6oKNmPFlmVv2N1PO22R+E0jfL580tHk1Kvu4SCy6aVMmICcubuuHSEIPZXW9+VoKZONZYvEMn9fU4H/jqrrSd/95lEobNjFhEokSBa4KfSryxvFHHB3xewxdAPFnvKZAqa1i5Lska6zKSuYFsmsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141717; c=relaxed/simple;
	bh=/ckRsrHFrU7aeG7XGLDQiPl7NyycZTI1IIkl2emyW2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bkOw6iLcOVYZCee/p3l1ogZMHjHd6aphfzWPG8CnfxkZFm3GM5qenDSjZh6eOy5yWtLKaCAK8qIg0yBWBPUT3fQBwXKOE7aficdDuGN2LmeGz2pKlAdGAvkkd5Zu/Fl/kwtIeAPzjT60z1FlBOB7AXxD31NjZFabkc+/Z/iFbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvpMFWsf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvpMFWsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0011F000E9;
	Mon, 22 Jun 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141715;
	bh=D1bneM2mCN98hSZmqxk4GKLwd+efElLVoDFRUpMrdhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GvpMFWsfBEfoGIJrskWt/9OxAW2wBoUk2kA4juiRXNFDk/CSfgMWmCO5RWluVwCCi
	 9R0kveb33YscMMwAfRdNdKRqIj3X0+i5ha5OYN7b4JhS5FltJvEFHvE+wUf3ByFfkN
	 HFkT1/73P4rsRE0XNvW+Qx/c7iSD0JtEPLgAvwRpy2yTvUNYxMK8bzum0gpfbgOwzV
	 t17IaomzJd3M18Id+c1m1RraMvkxXbYA7NvWFtKrU21ZSP6/eam/X7AY1Y3je53Pmk
	 KPvQE8cZBDOwqaLw6rMW0pe540q4whhY8cNU/NlvoHoy4GftEPRdGbMGTe5GX8S+dh
	 dDYVvPqUrAkEg==
Date: Mon, 22 Jun 2026 11:21:50 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 0/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260622112150.14d4c162@fedora>
In-Reply-To: <20260622234416.9f85ff87b81bcfb9776c73a6@kernel.org>
References: <20260622130739.375198646@kernel.org>
	<20260622234416.9f85ff87b81bcfb9776c73a6@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 23:44:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> The series looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

-- Steve
