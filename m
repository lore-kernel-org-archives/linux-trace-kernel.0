Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505EE30E829;
	Tue,  7 Jul 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434981; cv=none; b=iXy50rdloC3Io9d+zbYdOoav8F7gnlDIZIJzinjwAfSdKXK029K7uoeoUX/NFhOK7BbJN4EFBr2pMhjoJaGVwwWGWN1ezStJd6mGZgNNrzkFFfzDrRKBxXiJcRM0sibQrVnK0CxuJsdH5sC6HO8x/a2G58StAlWuqClzk+zGHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434981; c=relaxed/simple;
	bh=zUzZJFtUNddXrcCFyinFGC3IA74kDDT5imaFq8WXtgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRybSKe2Y95v9/wpuYlqILwcaky1YpOBj6BEAFPxCjVEdejRZKwJH910ibThKQC2HWHJQTFp5n5kZniDNVITy+zW2mhvMGO/2iYzaC4AkbLADKT4H8dLmuWc0LmaRnkxFDUP4HCj6FXrGIIYp0G1zWZD0fKJP+KNQeF/SfJNLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id F277E12048F;
	Tue,  7 Jul 2026 14:36:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 27E2520026;
	Tue,  7 Jul 2026 14:36:17 +0000 (UTC)
Date: Tue, 7 Jul 2026 10:36:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 petr.pavlu@suse.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer
 resize
Message-ID: <20260707103619.43b8b553@gandalf.local.home>
In-Reply-To: <CAMuQ4bUNbCM7oxnrXaT_oAoX+Guoo4_Bu0eO5dLR3OZ62Eu0Xg@mail.gmail.com>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com>
	<20260630101425.2f7cfbea@robin>
	<CAMuQ4bV-HJWbS7NHPGtoyKz-_+LR335phbXeOi83EbV6kn+3gg@mail.gmail.com>
	<20260630171603.26530150@gandalf.local.home>
	<CAMuQ4bUNbCM7oxnrXaT_oAoX+Guoo4_Bu0eO5dLR3OZ62Eu0Xg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27E2520026
X-Stat-Signature: n6sd6ozuioxupt18ze8gdscfz1amx7rp
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/IpjUvxe+gxqjIYkjqB8R0hOZKe1dBht0=
X-HE-Tag: 1783434977-240095
X-HE-Meta: U2FsdGVkX1/FIY1AIfOM7uQ+l1UH55gWhfFWZZZsLr8+AX6iKfNZ4NETdkd2BwKSCP0VdhkHbGMtLNiRkH5e1Q4U3Fix3QWmoVN7hQZLvoa5hWdSEHcIZ18D3yygTZ14nF8uuCVsOywJIvscUpVJ6sBSTgDrJXr83WdwSkRzEW/NaGwD+RWNjJWFAX4C9CV4MMUXYdUObkJEc7FmB75MUPlyeSQKbv2Cnh4rGoBQyrkcjAtIVx8CkgW/Zu6vMfX5lXAU+TvmQlWyeGMHxclSSC7LjXTDJud+/Xquc6rokEnocShSP+RSq0QX3n6Cnp8kyQAsiEW+UYOlnaktcwGGYJCRXI1VyxSc

On Tue, 30 Jun 2026 14:16:48 -0700
Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:

> Agreed. I=E2=80=99ll add an explicit resize-in-progress flag, set it arou=
nd
> the order transition, and make the external read-page
> allocation/free/read paths reject work while it is set. I=E2=80=99ll chec=
k the
> flag under the locks that serialize each path so it cannot race the
> transition, then compile and test the resulting v2.

Did you ever get around to sending a v2?

-- Steve
