Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08223B9922
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626987; cv=none; b=DgRVmPtab2yMg5CXEak+yNT8/KbW89/ia2RkwUh+m4xKxGdlEFY/6nu7muKCUOpYw0xixSwSKZuj+gLdyrpHz5GyQn6Nmtx3QvlR4Ro+dp6cc8Hvh8pCDPfnfTkIjw8dybj+aY0HAIzb24jDk7yWnzjtnm0FwTsfhGkif4TqL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626987; c=relaxed/simple;
	bh=6dt3Ufb5RisjOvIx7jeq08hJ7uBHukeiJU/N0FKxucc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg8YDpie5emSgqsimVraqc4tM2s24QxLrqvGCn/ZoGTF0dfTfLha78gnBBM6KIZ3wvQksGJ0dJd9Ix9tyF0KKfoYH7QGKLIzMI/XEHg4yzlk8/kP9lpnPoS9pML6Fjd20jQgoX1da0OV/dxRIC5IXbqA6few0HoFPfqvZTF7a9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqCcVFKF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqCcVFKF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1445617f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626984; x=1787231784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0e+2GX5rm60FuEMHuqP+WuIydlySPn3ZKCDLSPuaJHY=;
        b=lqCcVFKFtn4ZKme6XJeZ/9NLU9D5SvbsGFih2qUWcBroeFxATniGG6So2eTCtnSpMA
         jNgYxvX2IRciSv2egfQIixy+Ulj5l6f0SSHrRCRmsSwqs0k6oMX/V5/8kQ0y0+aGK0rZ
         qHj6SNe6XLEmXJRT61/d2XjRrMqoSqd3HWv4305ukJ3MyP2K7GLIKkMq9+X+WRQnM8ZW
         RpsCQSpTgmtDuiomCP6y+eXDWBl2GAOYOojZllXGymNAZZWg4Qnvm6ASzq+VAxgOaf/1
         lXDWpNKl4zba7KGetWnh+vBSNotk033br3ZuwF/1+PpVhESOX5kZgpHYLnJ+FG5PXN42
         E/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626984; x=1787231784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0e+2GX5rm60FuEMHuqP+WuIydlySPn3ZKCDLSPuaJHY=;
        b=OD6Mn0E761JQU4Lx0/I56g/4/+WQlX9k3cjmriEQ0MoTdSYSOiVUhQBiFCCyeivdCV
         vx4cQl2xyhZft0aEuW3m1ERRIzdcvglMKA72J8T62asCiKO6Jq+X5ypBT+on4bigiqNC
         kHQ90oNrvwrePaN0egmvBaZrkq5zfTb1DgR0FYBP/cExcpe0laxd3OSnBtCplLdUUoX4
         QarH1Uxjmvjkr5gUl6Kon4+CvZd1nBwUZsrorP/bmuxPy3tc/n8uYBzovpgHnR1Cudng
         SKhJU/qw4OmSPmTu5FP4diOxjvouCjL88/ks/4gkFgukkpkqgQUW957kf/iAe8JsJoGV
         2lIw==
X-Gm-Message-State: AOJu0Yx39dPbEivjzRhRnlCN6FQbLSK3L7q5j9EcPQwtYOTS7DTBofOT
	wAARm8Wxu+x57CoCjJVlH8P49P6KVX5ualudRYwXi2wATVvAY0Nlt/mhY2nU7ENE5w==
X-Gm-Gg: AR+sD10crV1TkPqKExCAyOcHXhuXkUnjDQOC5HjWADTkuuPsydgCIWCi8jGvXxVWcdp
	bEf4Gdl85NM6ACN/VVTzYnNW7/Rk0bFtZI1birPitJ64vaAzj8HVb/xxzHlTp70KcRrG28S/F+M
	CvmNJYloAmy1dkfWXpuDDA9sxBkk4VJjnaKNUDonnekmPFSukpGIxI8qewyZJSMakrmC4G3FXKv
	AWPopOXIpGRu3OG0KwUoUzWO/pQElv8sc7JJjjhA8nTgPn5GN9uTsbetaoGa7WCkfzr61917LFA
	JJUyfyLDZOhLYjK2zXF8rrTP3OZ8xwIF8/J8VY4rlyvxEsfhSZHaYuK78k2rwbqaZivj4ynI8sV
	3oDlnVJL/OrO4apmiuixEl5ZxEJfbuPWdVpTppI6/O2Q6SUR2n53/o9XTrHbl9Z1oFKP11oG7lG
	48JcaccYuOUuendR/2QaGMi7e6VrwdowSLAzBi+4PWFldpMvCjXA/m/fFM+m9HqpjHk/4r4+Zhl
	7P8t+Z+SdW7iIIJeXJeiMfXLMQ4v6kH
X-Received: by 2002:a05:6000:491e:b0:481:44e5:160c with SMTP id ffacd0b85a97d-48159ed68f5mr9844185f8f.2.1786626983301;
        Thu, 13 Aug 2026 06:16:23 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5c2769sm6333494f8f.36.2026.08.13.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:16:22 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:16:18 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/18] tracing/remotes: Gate tracefs files opening on
 trace remote registration
Message-ID: <an3DosTQoNFcOHs4@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-2-vdonnefort@google.com>
 <20260812163111.587781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812163111.587781F000E9@smtp.kernel.org>

On Wed, Aug 12, 2026 at 04:31:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incomplete tracefs gating: Caller-created tracefs files bypass the newly introduced `trace_remote_tracefs_open` gating, leaving them fully accessible if registration fails.
> --
> 
> --- Patch [1]: [PATCH v5 01/18] tracing/remotes: Gate tracefs files opening on trace remote registration ---
> commit 63ef30c302e1341f240b4f5b82d4e65d421da4cf
> Author: Vincent Donnefort <vdonnefort@google.com>
> tracing/remotes: Gate tracefs files opening on trace remote registration
> 
> This commit adds a global list of registered trace remotes and a gating
> function to prevent access to tracefs files for remotes that are being
> destroyed or failed to register. Standard trace remote file operations
> are wrapped to check this list before allowing open().
> 
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> [ ... ]
> 
> > @@ -932,8 +999,12 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
> >  	}
> >  
> >  	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
> > -	if (ret)
> > +	if (ret) {
> >  		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
> > +	} else {
> > +		guard(mutex)(&trace_remotes_lock);
> > +		list_add(&remote->node, &trace_remotes);
> > +	}
> >  
> >  	return ret;
> >  }
> 
> [Severity: High]
> Does this leave caller-created tracefs files exposed if cbs->init() fails?
> 
> If a remote's initialization fails halfway through, any custom tracefs files
> already created by cbs->init() will leak and remain accessible. Because
> trace_remote_tracefs_open() is static to trace_remote.c, the caller cannot
> wrap their custom files' open() callbacks with this new gating mechanism.
> 
> For example, if KVM's hyp_trace_init_tracefs() successfully creates
> a 'write_event' file but fails later, trace_remote_register() returns an
> error and the remote is not added to the trace_remotes list. 
> 
> Userspace could then open the leaked 'write_event' file, bypassing the
> gating entirely, and trigger kvm_call_hyp_nvhe() against the uninitialized
> hypervisor stub.
> 
> Should trace_remote_tracefs_open() be exported so that subsystems can gate
> their custom files, or should the leaked files be cleaned up when
> trace_remote_register() returns an error?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260812161340.2417322-1-vdonnefort@google.com?part=1

In the following patch, the tracefs folder is entirely removed on init failure.

-- 
Vincent
