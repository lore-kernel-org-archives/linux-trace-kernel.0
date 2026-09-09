Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C13AA1A9;
	Wed,  9 Sep 2026 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992271; cv=none; b=htzK9Fi7RuqoJotIZCHIQgZEgCZa5RUATZl34N296P3LOXhEag5HtB3/utwekZjym9eacVDTcTRDfttAmKieZAVpe5FS4FlmFswwpFJBgdD7onjG0LlRzl9JvD2Fg84D4ktUKMObYJZtjJnOZjR80OXYcI+cpjZfu9m3q7JoOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992271; c=relaxed/simple;
	bh=wXZu2weoWUsh9gF9sie1LyRlZ56J29uo8uXb7hampxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8YCW35B4yZMTRa1LIV6GFvJedqzH4QvzbuG7gcGbxFN0I8/vCchL3CpPsKSAH+omuSNkRC3StgSfWTWP7/KPlw+ju1E7f5XMt36fPZg6d1KKHuzDhMaHvaEcBFyBuNWxHio1EkR5d5+lXuRYOGQfWLvGRtlY3pfALhwHWnwK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=VC+DYLWp; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="VC+DYLWp"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 3D6D5160382;
	Wed,  9 Sep 2026 22:17:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 65DDD20027;
	Wed,  9 Sep 2026 22:17:46 +0000 (UTC)
Date: Wed, 9 Sep 2026 18:19:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ring-buffer: Unify ring buffer minimum page
 calculations
Message-ID: <20260909181903.403c7fc1@gandalf.local.home>
In-Reply-To: <20260907192643.42513-3-vdonnefort@google.com>
References: <20260907192643.42513-1-vdonnefort@google.com>
	<20260907192643.42513-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pycsogbm71zprx3ckd19kfcdcyoej35c
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 65DDD20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IHE3qDdDDeC/wXePHzMVA7xF2by98uzU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=CZba2QB2HqPPAIsOcT2uuuVSMqTcqSspKCQ3+oFzbzw=; b=VC+DYLWpvhzaQgNHgLPL3LOXx8gftJDCZzvqarOal20ZITx1zJo0CuY+XBEzMw7nmSCufqeaj+lzkigohViGZiWqGqsSbEf8Vumnhpnmp4tXGqQLHjCOjDDTd8o3Ni1IfREHrwl4swyUm6f3mrPbeJK0EwLSUF5Qo0Pfx8zQM5I=
X-HE-Tag: 1788992266-618164
X-HE-Meta: U2FsdGVkX1+Hy9d4BffhehlmNEid7/rPSC/soUXfBvBFe6K0x26KXkf+lffn4ZKCTg3mzLdQt7DhFIglPhfPBN5FRmK6V95y8ESJkVEKt9w3wvBjwY4FgK1A/N/BUQpccJxZzn7B1yAydK4bMjWVRcp2INC6UEJ1vw/bc7jloOtmIDMtgbz4ec1kH1hjXkFWj8VkP2pWQ6/yzykUz3g8p/o90wuH8dEGnp4Lfp5sItFtbOOPALHTlXTmlgLW5S3qbZK5IjKzOhadm9q78hNr6DKGg/c7Z1hetAjlePRd03PQ7B0WmhhTtV9cK1TOY/DBEEXOwYdHI2vrmUKWz3OMj4XJxJ39IGlm

On Mon,  7 Sep 2026 20:26:43 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> The codebase scatters hardcoded minimum page limits across multiple
> places. Introduce RING_BUFFER_MIN_NR_PAGES and rb_size_to_nr_pages() to
> formalize the requirement of two pages in a ring buffer.

Now I read this after I replied to patch 1 :-)

Anyway, I like my calculate_nr_pages() better than rb_size_to_nr_pages()
but I'm not really picky ;-)

I would make the helper function part of the first patch as you introduce
the duplication of the code there. Whenever I introduce a duplicate code, I
will usually do it by creating a helper function and using that function in
the places of the duplication instead of making it into two steps.

The use of the MIN_NR_PAGES macro can stay as a separate patch.

-- Steve
