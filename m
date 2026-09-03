Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9F32AADE;
	Thu,  3 Sep 2026 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445834; cv=none; b=NgXi/DTCWLz8AEGoykprBC4kdLLmkeHUR92Y7OWtf8rM1z2WyYlfosp4tl2GbrcWiQI5Oh+oRvMBTZysKAhmpo45VHCjKi671xeniw9+OLllaDLQrWlkKKFP5EfQbLiAlFcEBTha6PkIpc8HXyALcBFo7hV62QZUT4IaXuYqZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445834; c=relaxed/simple;
	bh=pu8ouhgIAntGL6unmelmTryxqPMDe246JXbmrznDPmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceLlcpp7ZSDI5evp6kK2OWeHKdooEBb8Q9ZQYLfPlTvRzVKUmBfT0tRk2cdJ8sPHidjlgukjSeu+9WQ21N1bIc/RXJwQ9LsGR1LDmIqAsuFzZeVvrSwSXJ3I0UgCx7HCCBUs0iB7+04h91lOIPOPOaTe6AFvRf+CzJAKafzJ9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=z3dR4Idj; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="z3dR4Idj"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 38F401404BD;
	Thu,  3 Sep 2026 14:30:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 4CBA332;
	Thu,  3 Sep 2026 14:30:13 +0000 (UTC)
Date: Thu, 3 Sep 2026 10:31:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] ring-buffer: Fixes for subbuf resizing and
 persistent buffers
Message-ID: <20260903103116.6cb7c39c@gandalf.local.home>
In-Reply-To: <20260901155445.1475405-1-vdonnefort@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4CBA332
X-Stat-Signature: dzpjbanoo8xnnjapzfc93wcb5z6yk44f
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+pkPendwrE+SUxjqe40cMDjXYFx7iTfN0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=xg1eImxmhZMYQ3hk/7PaDoIrMq81IdJS6B5oAdUL8pw=; b=z3dR4IdjO61+H3jSnRhYb5qWpXfeIY3Gr0ZXNcLjtQnt3yoo2Px2pBiApiaAD7rkOFjcL8mc6V5wTD4I1LNuVwUd5WYFdwbV0OfF+7Tba5uqFst/DJE1JVk4nd9VTBJcyoXYgIx6MGU6QisdTtitaSAvkUxmfkmebp+pQv5r5no=
X-HE-Tag: 1788445813-897403
X-HE-Meta: U2FsdGVkX1979hS64fQURrGOzz/YadhQuceL2VOAEfgC9CQ6SkaD2X5Vw3Ksp+FGV44n0ug6Hs6n3KeKlGViy+h3WJMYVuJ3J3JvYOEZh/h4GVMLcyTNDkAY8sn84IbkKeE4Cn+54w3G2j++Vivj72OD44XutM6a8iavMzTAnSe3TziZ+S4XG68vpqk7EbPyMKgPlWshaKvW1NKnMYNHSkXw/UB72gsGKpdwk4+5uU6Trx2bku6Tkb2fGBZLftqSFsr/vAGEaVwLq6mrvPTSVvw3DxNXiZzQK8QVieta9Pj34YQNGVmFJwQCn/I3LmZztXh2bSmorRqDfP67AjyqVTOz5Or3ptFQ

On Tue,  1 Sep 2026 16:54:41 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> This series addresses multiple issues discovered with the dynamic ring
> buffer resizing.
> 
> I have managed to reproduce a ring_buffer_read_page() race with
> 
>  $ while true; do for i in 8 16 32; do echo $i > /sys/kernel/tracing/buffer_subbuf_size_kb; sleep 0.1; done; done

Did you do anything else while running the above?

I ask because I ran this for several hours and it didn't produce anything.
What bug does it supposed to trigger?

-- Steve
