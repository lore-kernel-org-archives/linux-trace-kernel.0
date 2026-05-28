Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA472C15AC;
	Thu, 28 May 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000567; cv=none; b=JXfg4/mCi5CIPcVftcaAUpD1LBqD2uYvsccnbZCP6loYbEmnUy6UxNO34SbWejmD9FJ4bbr5tqaJGJGkH9o+Y0A09a3VGInoqzjR+uecSPBfHlTXCCaOx59OpD6ZLKqyJPSNyyDx5qHVR+tyEr+iApQZG3WdQawohcpL4R8APq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000567; c=relaxed/simple;
	bh=frmnDW9kpL2df7hiipqCJcOiiSNt0VIiQ0z2hJcDH7I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9dlK6rhiU9/NL6mib0bnsXrrn9Me0yjSqYjWQrJBsVxK8Qh3Mxqcb55xCKNPJ2+ltGTCR1vIb6m6QjWw5vqQzJzcQ3byp4OBKdXrESPe4ySz23LAVGSp3Dufu5lp3s6ehQpBSZI74pLDYBG/w0gEshF4eZpId8ZcAaI96GCQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 8B26E140925;
	Thu, 28 May 2026 20:35:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id AE72F20014;
	Thu, 28 May 2026 20:35:56 +0000 (UTC)
Date: Thu, 28 May 2026 16:36:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing: Record and show boot ID in
 last_boot_info
Message-ID: <20260528163633.5650f3d6@gandalf.local.home>
In-Reply-To: <20260524104439.ec01284998cae6d4a5053e61@kernel.org>
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
	<177937543666.2596845.9748178606108139386.stgit@mhiramat.tok.corp.google.com>
	<20260521111630.1f558754@gandalf.local.home>
	<20260524104439.ec01284998cae6d4a5053e61@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7kasc7hoizydy1yibiajssxcwk48cbgw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: AE72F20014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/1gP2YEmIDNOMhmsBD6Efg3aeNdzSzTJQ=
X-HE-Tag: 1780000556-698878
X-HE-Meta: U2FsdGVkX1+Pw7GfURPgMkN1UuBA0hdr4iJGLDnVxLe85IdWHN9vxNyFCYSmVaQ1J+jZMtBSj119AloptxpKh8p6NClGHMupubf6u0+QaNJyYkTys+at4QlaQto+ohf3gWcXNq1GcJrHX3+FScqmR7no9g9w2MotQKMzphu6+xcIfUymY50o1sZp1qhfwBAVctntuUKoAqIUySDSx89oXiFtvzGlpJtc7TxnSEbBiz73dGcwHITrJWjTSDjI8wwFWimSw3HTLEWls6KIqd54NRzoqg9EgkLOp8NjzQ8422uyEoVBqSmJky+7pAfj3JmCgAx9gPLO/Vt9dCE/Eh/gPoqXfqxHGoPS

On Sun, 24 May 2026 10:44:39 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > If the get_boot_id() is accepted by the random folks, then I'm fine with
> > this change.  
> 
> Yeah, BTW, Sashiko found this can be initialized before we get enough
> entropy for random seed. Maybe we need one more delay.

Well, maybe for adding the boot_id later, but the code that initializes the
buffers needs to stay early. With the backup instance, the persistent ring
buffer can restart tracing immediately.

-- Steve
