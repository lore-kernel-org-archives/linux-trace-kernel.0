Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6334A3C4;
	Thu, 21 May 2026 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377022; cv=none; b=fXXNnFFMZ8gA8hsRaJgAzvYJqZ+RUBeYXDsWBHgjkBQuK/ZD0RldPEsxSxIBo2973kZmjw6KTWzbyC8c5EnM7UTNmx5TmIPlYwZofOGvBiszU0FoBbYRKUQ9UnbQzDy+04euKU4sxjNCHJvvtPRckUaXBjhIyT3HWnJU9d1fmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377022; c=relaxed/simple;
	bh=Ppx3bRdLsklopp2CgPMsFceMhq0NdkAdj2SV8y+/Sew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBtrm8mXQZcBGY/XFVOaXnWLEsJGtT911rpxkBwtA0jsOvD7JwWdijAnubWbmIwGpq/btKKACvDKv/I63T0KgbmsroN4tUf6FJ1Ec5UtR6c/gbeoWaRe/DOgQeFcOe4wt9yyWRpEn8M9jubOZWqXXBbCZbweFKJSDp/1pR4niQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A78411C040B;
	Thu, 21 May 2026 15:23:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 94FC12002C;
	Thu, 21 May 2026 15:23:37 +0000 (UTC)
Date: Thu, 21 May 2026 11:23:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Pengfei <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, cmllamas@google.com, zhangbo56@xiaomi.com,
 lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH 0/3] trace: stack trace deduplication for ftrace
 ring buffer
Message-ID: <20260521112358.652a773a@gandalf.local.home>
In-Reply-To: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
References: <20260514034916.2162517-1-lipengfei28@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 94FC12002C
X-Stat-Signature: fbfcooewn58jmuagcpcy6hbib7zb9dtb
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dP1+13DqWa1LFz6Il+dFmJXnGlS0Iaq0=
X-HE-Tag: 1779377017-323624
X-HE-Meta: U2FsdGVkX1/bAgFu26xHUuBei3D6pWjhazHJ7EgvAMO+XSOBVfUI+EpIwLaarQqXtGvUlXx6nPCeDAHwxLUgvYV+KJG7UAfdHV4v1PbZiXquCtOBdrbi7QVRNHPCWLB46AQTjgA5FwjW4tWA5YVApBOQG2AU2HlvvXKm3wRs4yROvR+noLaZKFHSEkXVXVKu/eHTq2nXie+rjO/0HVYqRAySWTbZn+LBuAbFbAX8ZuR5ek9/WGQuMIzHiLYnGE6BV3k8+OelcMP5XOWWAjgf94mUrRR1vi+Vyd0YOiOfvHHphQBQAI/yCQqXAqP1DQWRQyYyKGuRLpzIQpQpa+8U8KMyOTmyhcfFfxiBzwdf+CMnZ1ND4UCCw6UakMwrllumTjxDryGUW60X4RXL9xqgs0hROzsHf0ttZVDEpJcJc4o=

On Thu, 14 May 2026 11:49:13 +0800
Li Pengfei <ljdlns1987@gmail.com> wrote:

> From: Pengfei Li <lipengfei28@xiaomi.com>
> 
> Hi Steven, all,
> 

Hi Pengfei,

Can you address the Sashiko reviews:

   https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260514034916.2162517-1-lipengfei28%40xiaomi.com

It has a way to copy the comments. Just reply to this series with a past of
Sashiko's review and reply to them to explain why the comments may not be
an issue, or submit a new version with fixes if they are issues.

Thanks,

-- Steve
