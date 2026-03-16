Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB023EA8A;
	Mon, 16 Mar 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669259; cv=none; b=MYKuiXkO7tA6iml9yIGySHuCeU6bADB5hfW0DCEetAlKnD8W5OvFCkMt2rdffkvqLD3jPinGl1DcG9k3Us1kugvaIbyPQp3Wm7KKZB6EOwpKra3BtxWq7+Xb4+d5+XKHuSG7X7mfXsBEHTNU3yix+0gBbGCoJuBWS1YjLxzDO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669259; c=relaxed/simple;
	bh=RTeM49aZsC8UTX/69GBo+Qakr8XwjIkDmxjCYSYMtV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgbA8vRjcjhG0kFQUiRVDh01HLruZetTSr+joA9bfBL3DAN/Me2gI/mN1HDHMOKRA/NzuBspIlK9HBTsQwg3v4IZ1V9A1ro9ruKW34SZdovqRk+TqxA0pScLc94w7QBxBmQiwi8EQ+Jgp3jv6mJxsH8V9ol+FSmNsQqtLi4hkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0C1E9C1365;
	Mon, 16 Mar 2026 13:54:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 1F44B20026;
	Mon, 16 Mar 2026 13:54:07 +0000 (UTC)
Date: Mon, 16 Mar 2026 09:54:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, elver@google.com, kees@kernel.org,
 lorenzo.stoakes@oracle.com, brauner@kernel.org,
 schuster.simon@siemens-energy.com, david@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 guohua.yan@unisoc.com, ke.wang@unisoc.com, jing.xia@unisoc.com
Subject: Re: [PATCH V2] tracing: Revert "tracing: Remove pid in task_rename
 tracing output"
Message-ID: <20260316095430.2080b8bd@gandalf.local.home>
In-Reply-To: <CAB8ipk8M=Uij65LZCbSAjJPPPsXWYY4kGBQwMm1WqJHHEb33eQ@mail.gmail.com>
References: <20260306075954.4533-1-xuewen.yan@unisoc.com>
	<20260306100625.2211675a@gandalf.local.home>
	<CAB8ipk8M=Uij65LZCbSAjJPPPsXWYY4kGBQwMm1WqJHHEb33eQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: h9sp9zn33t6zzyqqdz1qsirxxa9pn3uc
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1F44B20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18m9wy+n8M5gdFeLHtmOjs9y+6m9cjZSiY=
X-HE-Tag: 1773669247-219968
X-HE-Meta: U2FsdGVkX19oh2yjI9EpDRw01rRhb9BZGMqwpIXtpA7jG6I7v8DTuaviL/7XCYz7zA9bDr+cgr5lYTrYvnM9Pr1mDYPFY+j2RlBkgtSRoP4toQNd8ahX4wbuyuKrAbL6LyWK7+6xkgUgIPSh7mGl3kNS4ddoUmLg5M41ROE56TKuYpvf1s9q2283bTR1MaCq45EWc136zIJDYD7QbL8dsSAc9WEA7soGxNnk83Mh4vPPOQFZ/Wcigyzqn4HhwCbDCDVdhF8EGuUIwHebo8ihBRUjTry6+nPleypoRljVv58UGK8BwgKijTjAj6J2oRmfwK+hnk75X/5RTmlvu8mjc71psJXtl+nNQ3t4wtb4mlKVLmwihxIGNg==

On Mon, 16 Mar 2026 10:00:13 +0800
Xuewen Yan <xuewen.yan94@gmail.com> wrote:

> Unless there are any further comments, could you please help to take
> this through the tracing tree?

I guess this file doesn't really have an owner, so yeah, I'll take it.

-- Steve
