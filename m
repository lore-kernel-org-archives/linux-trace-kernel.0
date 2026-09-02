Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA94A2A7D;
	Wed,  2 Sep 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359926; cv=none; b=TtHnj6WzZqhfSU50B9WfcLbAo4Qn03b34MnvyoRjpmIfzBrqCFATAH3kGYfPVwCVlAMhE9BGG6dS4bho5TrPaew6/KLrnYkudxHfNmX+AIX5zwknYliAKjy1WomVOC+0v86Lg1Ab66TbrIfTbyoARVGvXyXNRNmatNCf0ffocRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359926; c=relaxed/simple;
	bh=INfjYsPwROmmhIRiUPQSd1pXkNc9oUc19N5sYMNK/dY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XI448Ivxu0fAJkFT2kNemO1u5/09dnVKnOJ0M00tw2pDH69gUtwijs3wrsO9Sd+SJ3P3R+HXo0uSyWnbR95C34U52xdaieAOlonu1hbvjCa3XIn4MZ3cp2q2jVleJ/3kif6452oGE7EACN+OPzUvXz2PoiWjCc2SGZvHpQuvYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Z2ZaRtG3; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Z2ZaRtG3"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 1A6FD14023F;
	Wed,  2 Sep 2026 14:38:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 73F062002C;
	Wed,  2 Sep 2026 14:38:37 +0000 (UTC)
Date: Wed, 2 Sep 2026 10:39:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Gao Xu <gaoxu2@honor.com>,
 =?UTF-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External Mail]Re: [RFC] tracing: aggregate ring-buffer memory
 statistics
Message-ID: <20260902103938.6cf6f61c@gandalf.local.home>
In-Reply-To: <ca552a4c093b4498b2e308d266d5ab6f@xiaomi.com>
References: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
	<20260827113815.0a0e37fb@gandalf.local.home>
	<15c244f5bc8f4858b8ffa2974a46d009@xiaomi.com>
	<88d476d443e74672957a5e0d1f8bf9ba@xiaomi.com>
	<20260902091555.450b521c@gandalf.local.home>
	<ca552a4c093b4498b2e308d266d5ab6f@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: jtydmfnpre5giy4t8yxi8hacespb757o
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 73F062002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+gGPWDhDF0xe+lImErs1VS48gUvn3WEqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=INfjYsPwROmmhIRiUPQSd1pXkNc9oUc19N5sYMNK/dY=; b=Z2ZaRtG3KNWWeOOuzxJUhXcLVffP9jUZzEVURCM+xwoYXfQH9hjMm35rs1wGbN4pWPwB7jKo5o9ZDPGCR7eJ1VZWvXOv7pC9MvfSg7QuAQGj5SADqoMpla0GMOtA7bGZWSdLmMyqyU8MslTeOVK5fcE9aq/Hb2XAdi5+cE4MUuI=
X-HE-Tag: 1788359917-521601
X-HE-Meta: U2FsdGVkX18UsHfgc5Y3ohWFlrue2dYo8ylPX6jADsn4vzI3cJj/QPEunSSAJGmSxjHvlkrNrhGZkaDDCRto8dMhEg/6jpm0mpNTOy8iSX7Sk2mEMN8FRXGy/CHRjIyrvlJfrjT6JaPMZYG9K3AjEFT/pbATEsS4D6CL6b5HQll5Do8r9kxQHIkiyHAJOxEA6Id1Bn/FDmfvYgdbfIlNLJCDbcWPhuc8+ZTKUrBZVLgeL2D6aNxawi2gr+oI8OBfHs1Rg3wr/3aZ95Qs12zNbdNs70yfG1eYX32j9rq3n2ykNz3HmBxdNo4UOnzuY4bOm7aIk1LcJaYHqmgueQQEF419X+UegXqu07m7mRiuqcjxR3y28Gncvg==

On Wed, 2 Sep 2026 14:31:17 +0000
=E9=AB=98=E7=BF=94 <gaoxiang17@xiaomi.com> wrote:

> The values are in KiB. Should I keep a separate total line, or will the
> two categories suffice for now?

Just the two lines. People can add for themselves ;-)

-- Steve
