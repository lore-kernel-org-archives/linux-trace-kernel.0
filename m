Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250C57C9F;
	Mon, 14 Jul 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509761; cv=none; b=FFsHGTNemfB6EkjznaDW+QSdmoUBXKHlUQ3bzwimg5uUlfWcx4LiUTU4lPvBlP9SOR7HhX0caGkAyl53I13mg4zUnbuzJ4UOobc/hr+MyJFAgmzON/YglpmmXfuyHnAUXiGCqDVpTRsZvjeU3sFJwMWYc0ozyTnNyZg2TV7df3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509761; c=relaxed/simple;
	bh=hzPhFpYf1JjML0jAXlNdx+r0UCTjRRvJ38zlLzSXZ6o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/sOb5PwFs1FIbrWsuSr1hK/tksg115tHJ/DH7FFN93JjL1SHH6u/lIJnesz4Dy+DRlP0iTC7s/aKoJKqLtftgse6yQ5H+fTJO92u89BV59bsIoqqozuDxgTeuysGL79l1pYD0r4Fy3znrDsFZRObbk6LsoVRVz5O7fPrAV4TqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id BD4871A0224;
	Mon, 14 Jul 2025 16:15:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id F1B3F20026;
	Mon, 14 Jul 2025 16:15:55 +0000 (UTC)
Date: Mon, 14 Jul 2025 12:15:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: make the const read-only 'type' static
Message-ID: <20250714121554.1365c93a@batman.local.home>
In-Reply-To: <20250714160858.1234719-1-colin.i.king@gmail.com>
References: <20250714160858.1234719-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qyc7t6s1ekhu977h68oxzfx6jr9r3g68
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: F1B3F20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX190CaTi4CqceogSjwc+ntpMA4+Km6acuZc=
X-HE-Tag: 1752509755-555566
X-HE-Meta: U2FsdGVkX19Ubc1spUOFXN91z59xB4yCMWR9If+YrYqahZwKwVLvjyg8IvqHBGi4zXHAQTXeXwqOWTSGNV+FWZnieo1jfcWvj70lvPQ05f3Nor8N6u9dhaicOVGEsz8YGrlYmHld/vVKCynDuOWdg5o49d04n0ZW4ckZ5LJVZYgR6aySOwA69Ng3Y2cOUa8fj7OGu0CW7dbaQ9g2VDtF2Fwk011QRjqqvAb8xLe06FI0GbQ6U+vf3EU1JfwdyLkdjQfJZl98LZV2IsxV8vTphpLfuDcn9Ibo/wyrzY3QlZdyheNa4pb2vCJvUyScBq1cAkspo4zgnZZUqPhmqv2h4X2eeZ9r1RE77QZxyJ998phuXlzUlGkISQ==

On Mon, 14 Jul 2025 17:08:58 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only 'type' on the stack at run time,
> instead make it static.

Hmm, why not?

-- Steve
