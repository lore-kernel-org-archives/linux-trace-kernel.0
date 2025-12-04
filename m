Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C806264609;
	Thu,  4 Dec 2025 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764861204; cv=none; b=cplyklv2ho9c2yePwyYWUuPnOmRBoy2wXiV9T1wxFcA6i50lHZYzMfoaaMQrRNuatfPw4SqC/JZYDEWYltpkNymM1JMe4R3pt7RVqD4ZCmgbdpvJPovzEf4+qnImldiiDFzLlvMll0JCl8BstPHcj243rnwQjAFc7wt0rkYygac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764861204; c=relaxed/simple;
	bh=ssBbCYvjCZJhgE1nFJcWZFdkknw1t8OtO8y6K93BcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCBa/pZmyfX6qkg6v7xol/NNs/HwvWtcKf3Ay8dd3DMHsiMQupqbqCMLMwB/yl0vH7aq/0WHnUgX7SNMeqew8vXKf3bnSb+C9VhlVaayvM2zL4MAbV0et4LqerTY+b7EtSeKzRbP/7EgzETkmg3cCae4rlefRpNOhsTWjxWTrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id F1C6C140213;
	Thu,  4 Dec 2025 15:13:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 4D04060010;
	Thu,  4 Dec 2025 15:13:11 +0000 (UTC)
Date: Thu, 4 Dec 2025 10:14:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Soham Metha <sohammetha01@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org,
 skhan@linuxfoundation.org, namcao@linutronix.de,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, bagasdotme@gmail.com,
 linux-kernel@vger.kernel.org, Jonathan Corbet	 <corbet@lwn.net>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/rv: Fix dead link to
 monitor_synthesis.rst
Message-ID: <20251204101415.284a7a96@gandalf.local.home>
In-Reply-To: <a34546391cc59f9f880ec271292ac201292bac61.camel@redhat.com>
References: <20251204032452.9523-1-sohammetha01@gmail.com>
	<a34546391cc59f9f880ec271292ac201292bac61.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rujjifn7nmmpoy6emxase4mo9xz6gpjo
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 4D04060010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18g2ePbYYWzvuSuCcxWBc4OByX3PMhDc5o=
X-HE-Tag: 1764861191-398429
X-HE-Meta: U2FsdGVkX184vYPUcvrLViW5zHJdPCatX83ejljFGPH2fxJ4h0hTwSpErVduYmjTrYR29tekZaaMHEdHIxFl5PRvfkHc4m9iPIhy7jESma/o2V8mtOQb1LtF0lkkJXgTDniWGsFCR+Uz39KOI+VI2COoi9bYUxX91atrBJBv+BNY/IH295o602LYWYPw0JZIbJgY1izfVs2P9aTvW/dVLyl6Kqwn8DEBC8R9mFMd0cClbF7biK/Modq4B0t3hs/g3D7yuutEXyXavPaoTUmWOfvJZU++z/xrv1gi/JFOtaWtKr/effdPerQR8QesxGpYc0cqvrahHlK/IbsEj4KmeARlBgK18kR1zGcrrJH3tP01UzSRT+pRQA==

On Thu, 04 Dec 2025 07:36:57 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Anyway looks good to me.
> 
> Acked-by: Gabriele Monaco <gmonaco@redhat.com>

Jon,

Care to take this through your tree? Gabriele is the maintainer of this
code.

-- Steve
