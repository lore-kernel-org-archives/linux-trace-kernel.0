Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315B37C92B;
	Thu, 27 Aug 2026 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844872; cv=none; b=XQdzi7FkkEjICAji//PlDlRcYw1JyTa6Sq4H3WifckqADcBsoBqvBEo2IP3f//H8T1Hg34fqjihysYEJDmLcj9oXEOl5Y/vahgjZ60vwRPb+/Q+6skNEtbNQ+Yciev3zMcYYSHDLDgD8qyHPOjPbcMnYOeAcwIy8o3VnYC28hFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844872; c=relaxed/simple;
	bh=zeLthRj1N44K7nUE4Kk51V9sd5wJvYb5pQsHIUteGRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0kacBAeoXx7StPs/DgZ3rjkzyXFCuIHZH80XK11LarxO9zNWNON0vo9k2Uz3mS8UqQRHj/w+56F5/3KZkCpFa63YVSN9MVyPgCqiyyXVAYdZKrse7FqelsuS2/h+2nQ0WxTAmlbWRjmwNMAg2oAVE3r1r+SnnginjHN57uWWj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=1+5EBzOz; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="1+5EBzOz"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 35C00A3ADD;
	Thu, 27 Aug 2026 15:34:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 0E91A19;
	Thu, 27 Aug 2026 15:34:25 +0000 (UTC)
Date: Thu, 27 Aug 2026 11:35:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Gao Xu <gaoxu2@honor.com>,
 =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail][RFC] tracing: aggregate ring-buffer memory
 statistics
Message-ID: <20260827113513.7355403f@gandalf.local.home>
In-Reply-To: <93406afe7c684d649f11b05d7b6b7b7b@xiaomi.com>
References: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
	<93406afe7c684d649f11b05d7b6b7b7b@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: pkri9dk5d7587xt5nkqjcfrecco55b6n
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0E91A19
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+qU1BRUw10bApCmjo11Q/K560n1OwpdOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=zeLthRj1N44K7nUE4Kk51V9sd5wJvYb5pQsHIUteGRY=; b=1+5EBzOzAM78BvpXloFT3FjTgIVYBVXb6O/c6hhH/daGwBx1W91N4bMTXUU+ITqfr22XP9fIEJt/n5o8Nf+uSP5raqgMJj6PhyQEI6BLcAgJAkHdIaWd6r/PTEbckoI6lHBXNz8sVai8OIibgTjbpKMkmMeW5Rflw2vkMQPJaqc=
X-HE-Tag: 1787844865-268250
X-HE-Meta: U2FsdGVkX188kldEsrz4FTTatbh2HN2KqM6MqUi31XhE1t2LzFTYPTwiSk+iwXeCWBIC4DMXqnApOfhomlRuKVvEgodJDdyPNWkSjjS4wvf6mhwUAPFiuQXvQzPQAz2ZjNWSQTZoeYDPat6oxUKGLeF2AFGWICoLCuoCtKNKtnZoBeWZ+fQCSjhm483EiBbuxOR1rcHZldVpg5bQtBjhMSo04K6QvB2uKu6wqELOLeIf2rf3WyVgalO0l3KHfwXB6FkZ9ZR2hOOQjSkAvnvyZ6fymO2zqHMi3HT9J+M/kTj0RVS3/YJmuS6/kSFFwMpwxolnAQrjRKvkR80wND8HJQ3hrmQRo42z

On Thu, 27 Aug 2026 14:25:24 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> Hi Steven.
>=20

It's good to ping after one week of no responses. RFCs tend to get low
priority and are looked at after fixes and other code needs to be reviewed.

But I'll take a look now anyway as I just finished sending out fixes.

-- Steve
