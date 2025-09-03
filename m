Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594F2D6E6C;
	Wed,  3 Sep 2025 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929141; cv=none; b=uXUOulgIrUZABebMw88YsQ6SCH6+sSVCigbR/SJBeax3WPG/KGnD2xzjs8cCK0Lo+HrNwcbbPnPzqMjH5N6OdWioIpCjRX+UnM08sN2PeQ9KGyh05WFPbLLHIQmD/PTshS1RHNZYkmiLBPZQ6p2wESu1Mc41NbEmN2T9SZZ9dgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929141; c=relaxed/simple;
	bh=0B6mSNJhF2OVJQLrYTy2yhKJ0LMoYfLhQ4g7lnSjS+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtVW5zTMy+FhTHThwFE/+ITs2vZ8zKoj6dl8I8MvRBKTQmOzINdKZzWK77gUrRw5kjopHDTUlYsfZEiPnZTx7l14NCDNs+voUpfUw8/kAa9TW49CFR0k4UwPsreB0GDjpsstgNTch45gdJLX7mw/EA/BtJPsefTb810hR/Pwf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 69526119966;
	Wed,  3 Sep 2025 19:52:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id C5BF920029;
	Wed,  3 Sep 2025 19:52:10 +0000 (UTC)
Date: Wed, 3 Sep 2025 15:52:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] trace: minor documentation fixes for clarity and
Message-ID: <20250903155209.058e22d4@batman.local.home>
In-Reply-To: <aLiH_zWPOsjMRs9V@gmail.com>
References: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
	<20250902102831.134a26c1@batman.local.home>
	<aLiH_zWPOsjMRs9V@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C5BF920029
X-Stat-Signature: 3ayb5ce7eyyj1m716bufqnjmq6141tc1
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WoUis4MWxAUS9SHyNmyLXD9CD0LGRcXc=
X-HE-Tag: 1756929130-121183
X-HE-Meta: U2FsdGVkX1/FMbgB+w60NCtJuWx6XNJZNM0yQeFa55/DoDZU/gMH3Pl2XmzAjBXugt6bdQ2OJsvv1R3qugj93hobo6UPEvYR5Pbwf7/lBy7z5ZTdvTt9ime+qQ3aAUodToQAp3MoPA+/GkH1DdPog9JxU16BCkw3kz6igQ43DMzOtpeHjWoDf6iGGkKBRS1rP75pVBeF5+HdiURXlpcASLEmZ0niSmnXXdQfHlgCT+dmt++V+HMwdyjgjn+srA6f3poPqP9L7hjGu23C2SRCRseuQ8+gx6uWeiD+Wj3GHeUkqhKIh/ieyasjEQKpZ/T8uZU0kQydAIPi2MATPcuWdkXO1Dvmi1SD

On Thu, 4 Sep 2025 03:25:03 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> Hi. Thank you for your comment. 
> I will make sure to add the change log next time.
> Please let me know if I should do it and make a v2. 

I already gave an ack. I'll let Jon decided if there should be a v2 or
not.

-- Steve
