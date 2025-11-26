Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D67302CC3;
	Wed, 26 Nov 2025 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168629; cv=none; b=USPUccAhuD+kRYZaqQER7E1kMEEwoxyrtqhc2w6xvuWqjzkJx5fGHb04uo2EMhTMgyfZAE+yFBvysxWByENM386hxa6HkZDYboYkNpYqQT5LZZvTyir516GWFARgZHYcBEv7mGIGOrnSfsK1gwigGR8+CqZgOYnbK7xS/RbD8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168629; c=relaxed/simple;
	bh=iHJbcw6Gs+weSpBNGgo1RrSqQicMcdJzqkiRG32pz/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIHiJYSZ/L/TQ5g3g0AO8WvfpoEdbi5UMLVfGdHG8mvICK+EP9qufN4S0ap3hknMGB9sHltwYZCauai89v4FrdYWkh9f7yGNAh+6II1fLCoM8ge8t4lyVolP/hVrV9tEibZ4nSD/1/tbl4WX7axKrL7hXQndHFOva1jvagTjJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id B9C8C160637;
	Wed, 26 Nov 2025 14:50:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 936B680013;
	Wed, 26 Nov 2025 14:50:20 +0000 (UTC)
Date: Wed, 26 Nov 2025 09:51:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers  <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
Message-ID: <20251126095106.7eadaba6@gandalf.local.home>
In-Reply-To: <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
References: <cover.1763370183.git.namcao@linutronix.de>
	<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	<20251125145736.48c3ed9d@gandalf.local.home>
	<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fsdx9qm91tyj9g97htxk5h7e3cenfwpc
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 936B680013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19saLtDXXaFoVI9ly+Ujd5XOUjJAQUX41U=
X-HE-Tag: 1764168620-562824
X-HE-Meta: U2FsdGVkX19DYzQKSm/WJukO9Ccg5XudqOaXoj//Tzh8S2xN1yCZK8CfEcgYkEAm1IkcnEGx4K5WAuOqMgysyga/oLyLWdPsQ39tjfZOV0pzzrRUjD89luJby3v9Zh8LrmoCg2o3kImQTPiKsxvNcL1Jzcqd6HV0COIoAxCK3btuP4BiKuVieeccCwNKGGds5qHW65zyaQ+JM5110VNy4mnRnqhCqdn2RH+OhqEjKAT/JtNusCFa3YzUezEvofmvO9jj2XE5Y8JIL1na8Clio4Poi7slwyoiayZ5UcaDdpIGByMxYIemj1yStDUPRK29IeATrrMDIwZuVi4Ho/vR5HUz9kAJ5Kb9

On Wed, 26 Nov 2025 08:27:42 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Steve, this is the only remaining change before the merge window, unless you
> prefer to keep it for the next round, I'm going to send a small pull requests
> with those two patches alone.

Feel free to send the small pull request.

Note, it's a US holiday tomorrow and Friday, where I will probably not be
working. Everything will need to wait until Monday, which means the merge
window will likely be open.

-- Steve
