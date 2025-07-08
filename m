Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81C25A337;
	Tue,  8 Jul 2025 22:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013070; cv=none; b=Aud53RRm3mjzPiE+Wo0/6cnstlIhBt2kbmnTdbpYtVm7vg8fWVoDsuOKaAtxBnWDagipdGCzaQsZ/2JCU88Qdf0hFCSXHm26wzE1piiB9ULFmaBhpstVJiCw9Dp6OvtaABopdjonzSc5n5hbc3NZc/59owTy3vLhvF4FmmWrszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013070; c=relaxed/simple;
	bh=OERbHD/6UtndaUo7nvHq24lajNCUAEF0sKY39B869HM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD4lqTdoly/m0mtWXS9UQOQloiStxgSzGF0w1EQmGHYnWAOvQyqGz37SxyxXAA27Qg+LDYOI+0evnmvaV/LQRwsLuIkJJnUlfcXHYlbdFWZ0rq4hJcIpq4/OJOch70AAwIfo+XCsUfnoOJNBLEWOxV670IWRxgXrFaoD9OTi7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 810018026B;
	Tue,  8 Jul 2025 22:12:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id AF3FC8000F;
	Tue,  8 Jul 2025 22:12:17 +0000 (UTC)
Date: Tue, 8 Jul 2025 18:12:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20250708181219.3abf0871@gandalf.local.home>
In-Reply-To: <CA+wEVJaH8NcwUoobn7UMFBJzyT-4xyqD34bntmWCukKLAPbG6w@mail.gmail.com>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
	<20250701195939.3e297e20@gandalf.local.home>
	<CA+wEVJY2a_ERXemup7EefPPXHOv8DAfyauuP6Mn5vHYFkbbBcQ@mail.gmail.com>
	<20250702104058.3cf9c1a3@batman.local.home>
	<20250702111908.03759998@batman.local.home>
	<CA+wEVJaH8NcwUoobn7UMFBJzyT-4xyqD34bntmWCukKLAPbG6w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF3FC8000F
X-Stat-Signature: w9f48jxqpkpb6ttk6i46mqws8mdozor3
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18InQAfwwpmMLLDsRbnHspREgFUtWbhi7s=
X-HE-Tag: 1752012737-798506
X-HE-Meta: U2FsdGVkX1/anaBaOgEloSRMzu8chxhapLLyCRFOLwJWHWUNpxIak4mJ+vTOJqPm4YBE+b//pBcP11wZNhw5pbAR4LQ01evnXV7znJBX7lUAcclxy7AgCroRvNwzFnXKEyYShiolatkHNMOcejs00tucnxEIGMZsyj003DYzEH+m/UjwP2AR0ZtrLIlj0yqKWpFTBCO9FLFiz4Au4tft0luS6QKwKtLB6er3PTLzyhvGZM8mxHJFkGt7n9zt/tT7U9LAsTpGMHh7L8meMTaJEzbSwFRL/VnHcX/JHGWs5fhVgOU8JfkzzcyF2LDV6fVCiRfJjDrF3YuVITQn7cHtqWUdIcQHY4xQ

On Wed, 2 Jul 2025 19:16:56 +0200
Gabriele Paoloni <gpaoloni@redhat.com> wrote:

> I also cannot see a reason for an atomic counter. Please let me know
> if you want me to add this cleanup patch as part of next patchset
> revision (if so the doc patch will change accordingly).

You can send a patch but it shouldn't be related to this series.

Just send it separately.

-- Steve
