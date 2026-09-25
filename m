Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835EE4F55C4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371172; cv=none; b=EWbFgm7pN23ATudvRL7g/jZkigZ6nj2AYn+075XalL4JQz5nGhJHvVoiNvcXfAt0hNjHKXERCzVguJ0JxhpxYd/1mGSJFC0P6+4C7Nw2kH7/jCjIhwBSlhtS9GT6sUnUTztRHcuvJbg+xr0/obzdjHjltVyxbt3pehYaOITQP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371172; c=relaxed/simple;
	bh=+ycUu4Lrfdhzd9jKGwQrR5OBQYug2brCLTLBMKycAlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufOiQe4OwWhSrsksj8iU/xCqGlUeyy0XMKmN1kS9TM3Hpcy5vrV3p0svEtCE8w6CXXW3U+2o19wKnQuRh5eUUDo+d7+ib6TcR86Li8WcdHSBkHyelCDCOqH8nB/el0v1UNpUHyKtvPKve+diRbfKFg9gNk1yUiEyxOyCpxna78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcgtoNnN; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcgtoNnN"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so688231eec.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 14:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790371170; x=1790975970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BSFDJmV96PMiREIfL8Vp0Pof+pF3vE7NpaMcF3TO54=;
        b=BcgtoNnN7tyT5vXhQxH2W/svjj04rjfZBk106Yx5Ud7AdBiH36T4d3HMQw4OKcx8Sq
         NSM1vLK6E71a3ci5ofu6g4WdMJ9lDPD/0Vcx/FyPu6F9VzovP6Lta6Wlt01yttgWz0W1
         8Z3YgLtmzsDiboBvrDdfOWCFsKNWW2peKDw801gsQ4fYGmg1QBitC25naGpcGWZB424v
         Hk44SSp0/6Ie3W/gSdfw1W9BxtikJ2//by1ti504vamhy+Imv72w+IeZgrh8gJHy3a+/
         ReuZTohoTELW7MiJjEDd9lcTjXHtDCM80++FO+XxJ4oRlHFEYa/ejek8AkAeRZpBlYOg
         fr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790371170; x=1790975970;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BSFDJmV96PMiREIfL8Vp0Pof+pF3vE7NpaMcF3TO54=;
        b=23t0JtUHnEcbop0+8uikZ8Osa6G2N1vgWcORGOmwmk/gggMIP1mZvTvsqEjHPBTteY
         Im83awLyAabCEDNWjpkEtB3Ii7OAHjefv7CB3rtoTVmRUN9acgb/xejfWzX+mAWKPaLj
         PF0qmsBzDeqYGq3m5szD7pEkH38OTawsYR1E48aYUXZhYhNXgYOe85gKbcxKkODDKBF1
         UOhj+AtxoLoeKFn7ejsA40Tgtn0iX3is4nM0wrMjNc5/fa9+PMHmjuS8xsXvoiHbU5rH
         0iNmrJ4kvU2nhaIA+gH0IEZPscm57mc4TS/u+TASnwooSTbEf9dSgI0u2O8mzc4Ca24t
         cDdg==
X-Forwarded-Encrypted: i=1; AKwUvByTUl9T0ywxur8DlXtFLUj2GUIHQD5a7Yet1Pxpx6C6Q+7l8M/cZmIdpfxyztDD9L4TERzkOX8ccUUfmAFWrGt73Q8=@vger.kernel.org
X-Gm-Message-State: AFuF++krOKTXYMspz0giethn1xpj2H3ChMe4SGRHDYpyui+cmaTCUYnh
	DBzbDmvzzVYrrpYUJs1BDMkC7fBg+ul1hLvlPgBOVhaDlXe0gKY3Pi1O
X-Gm-Gg: AYBFou1XmunI4IMPjyRW9mVsCqGY3yZ7Q++4H75p2MFINss/XlON7gxMaIShWnSsWPP
	Jh/EWR53ebhvd4r11caHIDoTHWHhhrquTpv7Dni4oQOyRNBSIKW4FusRRnj2rqYXRt5RXdN3FvZ
	oRic7JxFa1yQZ6qQ+GnaBmu9DAyjiQTMYmzFvdis7U5dDzabLHUsyny7EADtYTPy3YznI7x+3mq
	ScheWRlrLktlm7bhx8lWcfQAMAx7bMbbLEc2G5unICwPEdNbFWOy6AxvzT9GtmUq8lkAXXCs4Pw
	1AqYMpt0U+/bdDh/lbPYQ6J2q2YGPtIdbtqlAjCGz6gS9Tgj5qR7W8z6wgMpjRWM8U1kC4R2KA9
	a8W8QJbYMJ/P8A+awXJzUJmfsZ/eCc4ne4wb9sL5GbZ52ToYiJEoFdqayvyBlnjI6Opyg9RSbRh
	9eMiSSFLfsMohbr8SgcstD0N/kWMMPllgwYq7d1a9/HEA11VPkE5TjMXNkYBoG2LYWr4KM8xw0b
	jVn0ESMw/wwe9LAoVz+X4qJBdDFXgT/cu3F3Tg=
X-Received: by 2002:a05:7300:dd48:b0:33b:eb33:9f70 with SMTP id 5a478bee46e88-34272a41d89mr1027757eec.37.1790371169410;
        Fri, 25 Sep 2026 14:19:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:375:19cf:5fee:be32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3416e4c2f50sm8029385eec.27.2026.09.25.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:19:28 -0700 (PDT)
Date: Fri, 25 Sep 2026 14:19:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <arbkvK54vT7SIyjV@google.com>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-2-52b05f4a965c@linuxfoundation.org>
 <apA8n524yIn-g6ep@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apA8n524yIn-g6ep@hovoldconsulting.com>

On Thu, Aug 27, 2026 at 03:33:19PM +0200, Johan Hovold wrote:
> On Wed, Aug 26, 2026 at 11:19:33AM +0200, Greg Kroah-Hartman wrote:
> > The ability to add and remove devices from a driver through the sysfs
> > "bind" and "unbind" files was created all those decades ago as a way
> > that kernel developers can iterate faster, and provide a debugging way
> > for users to attempt to add a new device to a driver without having to
> > rebuild their kernel.
> > 
> > This api over the years has been abused and recently come under a major
> > fuzzing "attack" through tools like syzbot which decided that it would
> > attempt to just randomly bind any driver to any type of device, causing
> > loads of unneeded errors and pointless kernel patches to be generated by
> > unsuspecting new developers.
> > 
> > Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, which
> > will be set on the driver if the bind/unbind sysfs files are ever
> > successfully written to.  This lets kernel developers "know" that a user
> > is attempting to do something that is not normal, and as such, if the
> > kernel breaks they get to keep the shiny pieces laying around on the
> > floor.
> > 
> > Note, the taint flag gets set _BEFORE_ the bind/unbind callback happens,
> > as many times crashes/oops/warnings/failures happen within the callback,
> > and the taint flag needs to be there to show what was being attempted.
> > If it were to be set after the callback happens, the oops report would
> > not properly reflect what foolishness was being attempted.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This makes it clear that this is a development tool, and it is a good
> compromise preferable to adding unnecessary complexity or suppressing
> the attributes completely just to prevent root from shooting themselves
> in the foot:
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>

bind/unbind without overrides should not necessarily be treated as a
development tool. For example with I2C devices you may want to unbind
the functional driver, perform firmware update from userspace, and bind
the device again. This will ensure that driver is not confused and at
the same time you do not need to put into the kernel code that is
dormant 99.9999 percent of the time.

Thanks.

-- 
Dmitry
