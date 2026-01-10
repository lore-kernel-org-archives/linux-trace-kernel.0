Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF325D53B;
	Sat, 10 Jan 2026 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079433; cv=none; b=kd7ZkqyS8rtgV8xe0y35o3iA56Xp//Nky+IyzPQdAei/fcCjtNETXX+kOJHvT1Fo2vwTTGw7qxVpj3b937ZoL4FqeawYqKeGRI4enWASNT1ZzIP6cfgwERb6uH+cdjCI6RmuXnxgXH0F55FOrgUTemJVqCB0bnn8+sic4qvwyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079433; c=relaxed/simple;
	bh=z+kwmRyIZkWSSRmkrRQMt5bEn4AoPcvbvovPw7WPogo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1kdeHu4WehTbEVyBLhQeIlk6Xgg2UdFZt1I/xCpQViX9TNyGBV2SZRLU5lVCxn+MdpRkQpO6nJJNyRCBP5/cq5RTcmX/8jSL5uyyH2kMPFMjr94XkC+k9IUcBzTet91h4XTFl1MRlgvXkgmc39f8DMaKT60c7XYMSvoKh0zOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C78771602D8;
	Sat, 10 Jan 2026 21:10:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id B271F20025;
	Sat, 10 Jan 2026 21:10:22 +0000 (UTC)
Date: Sat, 10 Jan 2026 16:10:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [v3 PATCH 0/1] tracing: Add bitmask-list option for
 human-readable bitmask display
Message-ID: <20260110161021.2aa5f19c@gandalf.local.home>
In-Reply-To: <sm4xoemzv7d5pkyudybpxydriukvnlkwiaxrbh3qgevpnxphha@x7gberqhyjdo>
References: <20251226160724.2246493-1-atomlin@atomlin.com>
	<sm4xoemzv7d5pkyudybpxydriukvnlkwiaxrbh3qgevpnxphha@x7gberqhyjdo>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nfmw5b577ebnthm598mxmxn65a14h4gd
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B271F20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/rqQ9wicZgwGVApK3r40yFFg62CjzdMfE=
X-HE-Tag: 1768079422-28671
X-HE-Meta: U2FsdGVkX1+O6zhXVEnwX38w+QDC8KN1GbL5NzTe+VFrSjrbnRvCmBTYAIopUc/mYoJi5DrYQeBQ2UQYXAN0NW3MiP+VUbVAia+aNmKwBV+DI2zIMk16J1oUQgiOTzeoCrlWXswtlK8EiiDEXWvwPycJ8ku6Dnn9Gdzd5+lgweaPPHWHFnQNThK6M3aA8CKCASvd+ceDzCiF6tnJvsL7whcdwhDtvODFW9tAlyr8miCPlNQIiOusKItL7KZohLfPL6pbW1PvPmUTzPkSXhUKM7AdNixEk0fkaEUIkk03Q7fJdxUaS8t5hOQTw1qwPCYBN8J63CvTDT5g0q5ygRS9NFKIYWCyCVZ4DJQjlHKcAiJKpgGjYBbRQm4H17W4mKjfTg37BkKpHcAeE3J8iZEURw==

On Sat, 10 Jan 2026 16:06:02 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> On Fri, Dec 26, 2025 at 11:07:23AM -0500, Aaron Tomlin wrote:
> > Hi Steve,
> > 
> > This patch adds support for displaying bitmasks in human-readable list
> > format (e.g., 0,2-5,7) in addition to the default hexadecimal bitmap
> > representation. This is particularly useful when tracing CPU masks and
> > other large bitmasks where individual bit positions are more meaningful
> > than their hexadecimal encoding.
> > 
> > When the "bitmask-list" option is enabled, the printk "%*pbl" format
> > specifier is used to render bitmasks as comma-separated ranges, making
> > trace output easier to interpret for complex CPU configurations and
> > large bitmask values.
> > 
> > This iteration incorporates the use of iter->tmp_seq to ensure the
> > implementation is robust, instance-aware, and free from buffer contention
> > or duplication issues.
> > 
> > Please let me know your thoughts.  
> 
> Hi Steve,
> 
> I would like to ask if this iteration is suitable for inclusion, or should
> any further refinements be made?
> 

You can always check the status of a patch from patchwork. This one is here:

  https://patchwork.kernel.org/project/linux-trace-kernel/patch/20251226160724.2246493-2-atomlin@atomlin.com/

The states are:

  New		- I haven't looked at it.
  Under Review	- I have it in a local queue (can still be rejected)
  Queued	- It's moved to linux-next
  Accepted	- It's in Linus's tree

Other states I will most likely have a response to.

This one is currently in the "Under Review" state. It also means I haven't
found anything wrong with it. It just hasn't gone through all my tests.

-- Steve


> 
> Kind regards,

