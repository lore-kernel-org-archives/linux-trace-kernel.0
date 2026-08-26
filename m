Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D294279E0;
	Wed, 26 Aug 2026 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787754371; cv=none; b=rYzCdHfnJ6+yhwZkkPWPPKdmVBCvonwo6yIxeL/GBZ711Cet1qmEAAuPyhtA2UWnEmzNG9ahOCIVvKiFB8qGoKK/VyeCN6zntKjthrN4BD5ZPfv9PJZM6T0NzliwHx6OQHgITAfepsjqSq7B92wcaPoO1BLcM5UDAiS8h6BLmIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787754371; c=relaxed/simple;
	bh=AVOKQA4sQ8UfjkWFKXX9X4kPsx8EbqaZ5rlBF0ucbuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sngyF4iAj3BrZ0oYtK2T+zo3hVHeY0pjRYJZRgEUYvf0hrY9stnJepZkgQhyMecIKiDlFZIcROzk36u12s92GkHqVlVS/VcQU32Spnu7tFwDcsTm+xwbF+A/t4VfkzhpO/ohJagUHrUv2BFIust0HR42J/kVdy2bhlw/OenVCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=b3W0hUvc; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="b3W0hUvc"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id EF30C80135;
	Wed, 26 Aug 2026 14:26:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id C81F680011;
	Wed, 26 Aug 2026 14:26:01 +0000 (UTC)
Date: Wed, 26 Aug 2026 10:26:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: gregkh@linuxfoundation.org, atomlin@atomlin.com, corbet@lwn.net,
 da.gomez@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mcgrof@kernel.org, mhiramat@kernel.org, petr.pavlu@suse.com,
 rafael@kernel.org, rdunlap@infradead.org, samitolvanen@google.com,
 skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20260826102646.46da2be8@gandalf.local.home>
In-Reply-To: <C35F2CF9-9CD7-482F-8F30-2D152AB42D0B@mainlining.org>
References: <20260826-bind_taint-v1-2-52b05f4a965c@linuxfoundation.org>
	<C35F2CF9-9CD7-482F-8F30-2D152AB42D0B@mainlining.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tddcp93b9we89hjdic17gw6xje51qxdc
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C81F680011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/PXk0g8T9dvGx2b3nPHO4w9H0oMny/sQU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=AVOKQA4sQ8UfjkWFKXX9X4kPsx8EbqaZ5rlBF0ucbuk=; b=b3W0hUvcVV7JdOj/H/3SKTT/hWFGjCzgkAPVHEUiXPN+W9PVox1pCmRMqTX6Kz3U8DXlgib6LkQ/SKaNrs/6s9AA4/tLIY1HTPKSs9P4u1mWjdmvwX9Bvob0+9gqipvA0XIt2fRp/ATscjk8Z2b/PXgGEx0mzk3Cge6Oprh/PWE=
X-HE-Tag: 1787754361-696113
X-HE-Meta: U2FsdGVkX1/PUWaXKG5abTJtAMoeEfdFMPdWi+ITyVSTKMD1WUAWM6Er7Ul9m3ht17S8iVTtzphtHpZ8AoNaYsMhU2t+DcJL7dgCe/tbBPJItmZK0UWaPKfcQLKKMAOh65NZEJluNDe11oqk2zt+RJJrTGXHa04ArsqBoN2otu66MCrDMWd5tXxSVWhWWwpGDUj0MM8a/srLClsm6fUCsq2nWW8hM7+MjyNouNDVqjCE/yTrhRTsTS6peP1RHcf48Cre0OGCOwDmuNeUEp2lQfqxQL0Sjn049099oohmHoWEkYmdSCsUsw28xX/AntF0LvqOLqfsNNgOvsaEfqowBklUm6d9+Lzi6o/9dJOG0vlugPnpF4cqkY9fZMh0axMF0W2yKmh4kyrwbnsKn6JCPg==

On Wed, 26 Aug 2026 12:58:00 +0100
Bradley Morgan <brads@mainlining.org> wrote:

> sashiko found a couple valid concerns for 2/2

Sashiko will respond to the email if it Cc'd linux-trace-kernel, which Greg
did. No need to mention Sashiko. It can speak for itself ;-)

-- Steve
