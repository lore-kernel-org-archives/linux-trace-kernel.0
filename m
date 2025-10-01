Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DBF1BDCF;
	Wed,  1 Oct 2025 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320937; cv=none; b=cLHbOMveJvOlKokDlrnSgAgk71ENXO625OhEv0JkQ54RrsjirjOYDzCmFLCVNkyp+mQlb3CeknhjmUz07naaAbSTGUpmQrRIio00pLcYTQ2sNzbO3YLN43x0GJtzZTZ2XUraL9BAug4PpgdQuAd3Ga0AtHGybvcVbmZjt84pPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320937; c=relaxed/simple;
	bh=Mve0cLEyn65HsDLL8hjL/NDcoAseOdEOViRrbizip0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3gvgrZObcxRNZ4aawtxiLCjCoKym0L2NWYaNzm6+i4uHa0LmMSVmXUZcqUXbwa3DAn6+Tl+18CfLVe9Y/7ni3cdBCMrKD94YEBhgz6qIgnB2LALRRzSqGWJKikEZYQMvw8m9fI5tgzPZsYMUXN22+ZjaabWt4HVd0u7npiS9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9F840447DF;
	Wed,  1 Oct 2025 12:15:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id CAAB920026;
	Wed,  1 Oct 2025 12:15:25 +0000 (UTC)
Date: Wed, 1 Oct 2025 08:17:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user
 with memdup_user
Message-ID: <20251001081703.3befdc7a@gandalf.local.home>
In-Reply-To: <1ED366BF-BAF8-4140-B260-B2A40B5E5996@linux.dev>
References: <20250925211736.81737-1-thorsten.blum@linux.dev>
	<20250930172841.63dc86b5@gandalf.local.home>
	<76B6CC10-1C0A-42D0-83E8-8CA8A7790BF0@linux.dev>
	<20250930190932.26b49afe@gandalf.local.home>
	<1ED366BF-BAF8-4140-B260-B2A40B5E5996@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7ofshxyrjmjnkawwknwqdq4zpi1rdn1u
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: CAAB920026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cx549b/knm1bFJm4EvTie8uJJLg9T9cM=
X-HE-Tag: 1759320925-115967
X-HE-Meta: U2FsdGVkX1+LBQNKFu+vH1cd78TIlbkjE0Ucy8OTrPCYgfxVr153zwljK/I3vkhngZjeCmvQkuvgReKiRfRFCuYlFbc2KHP/t58HCxgXX67lBen9dIE48RDgwJrss8nUUEZJymsePkIX8FNPZP9O4tD8Bqp8HKAuJXUqW4q2u5+Khl1y03uuPg5GieV5wsuw3w1Rr5Gi1Vg+cb+APYBPqtBT4gO4gOLJn2vGqT8zG1ptxvO0ZuEfwKFaUD4bsKJQ3dTg//oqQuPpuX33F85+8WG0E7nPrXaU8EZsHx6tJbKM9GM2ho+m4aSTtuepM05cJ3EwrXGqKdsm8d9yEmYEnhgRJz7yxdXD

On Wed, 1 Oct 2025 11:11:16 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 1. Oct 2025, at 01:09, Steven Rostedt wrote:
> > Thanks, you can base it off of my for-next branch.  
> 
> I think your for-next branch[1] doesn't include the fix a2501032de0d
> ("tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()")
> yet, does it? My patch would need to be applied on top of that.
> 
> Thanks,
> Thorsten
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/?h=for-next

Interesting, because it failed to merge when I ran my script to merge all
my "for-next" branches. :-/

Anyway, apply it on top v6.17.

Thanks,

-- Steve
